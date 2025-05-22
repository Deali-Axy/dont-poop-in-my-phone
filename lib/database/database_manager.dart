import 'dart:io';
import 'package:drift/drift.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/index.dart' as models;
import '../utils/index.dart';
import 'database.dart';

/// 数据库管理器，负责数据库的初始化和关闭
class DatabaseManager {
  static final AppDatabase _db = AppDatabase();
  static final DatabaseService _service = DatabaseService(_db);
  
  static DatabaseService get service => _service;
  
  static bool _migrated = false;

  /// 初始化数据库
  static Future<void> init() async {
    if (!_migrated) {
      _migrated = true;
      await _initializeDefaultData();
    }
  }

  /// 初始化默认数据，包括白名单和规则
  static Future<void> _initializeDefaultData() async {
    // 检查是否已有默认白名单
    final existingWhitelists = await _service.getAllWhitelists();
    if (existingWhitelists.isEmpty) {
      // 添加默认白名单
      for (final path in StarFileSystem.PATH_WHITE_LIST) {
        final whitelist = models.Whitelist(path: path, annotation: '[内置规则]系统/重要文件目录', readOnly: true);
        await _service.addWhitelist(whitelist);
      }
    }

    // 初始化系统推荐规则组
    await _service.ensureRuleGroupExists(models.Rule.recommendRuleName, isSystemRule: true);
    // 初始化用户自定义规则组
    await _service.ensureRuleGroupExists(models.Rule.customRuleName, isSystemRule: false);

    // 可选：在这里添加一些默认的系统推荐规则项
    // Example:
    // final recommendRuleGroup = await _service.getRuleByName(models.Rule.recommendRuleName);
    // if (recommendRuleGroup.rules.isEmpty) {
    //   await _service.addRuleItem(models.Rule.recommendRuleName, models.RuleItem(
    //     path: "/sdcard/DCIM/CameraCache",
    //     pathMatchType: models.PathMatchType.exact,
    //     actionType: models.ActionType.deleteFolder,
    //     annotation: "相机缓存"
    //   ));
    // }
  }

  /// 关闭数据库连接
  static Future<void> close() async {
    await _db.close();
    _migrated = false;
  }
}

/// 数据库服务，实现所有数据库操作
class DatabaseService {
  final AppDatabase _db;

  DatabaseService(this._db);

  /// 确保规则组存在，如果不存在则创建
  Future<models.Rule> ensureRuleGroupExists(String name, {bool isSystemRule = false}) async {
    final ruleQuery = _db.select(_db.ruleEntities)..where((tbl) => tbl.name.equals(name));
    var ruleRow = await ruleQuery.getSingleOrNull();

    if (ruleRow == null) {
      final newRuleId = await _db.into(_db.ruleEntities).insert(RuleEntitiesCompanion(
        name: Value(name),
        isSystemRule: Value(isSystemRule),
      ));
      // Fetch the newly created rule to get all its fields, including defaults like createdAt
      ruleRow = await (_db.select(_db.ruleEntities)..where((tbl) => tbl.id.equals(newRuleId))).getSingle();
      return models.Rule(
        id: ruleRow.id,
        name: ruleRow.name,
        rules: [],
        isSystemRule: ruleRow.isSystemRule,
      );
    }
    // If rule exists, fetch its items
    final ruleItemsQuery = _db.select(_db.ruleItemEntities)..where((tbl) => tbl.ruleId.equals(ruleRow!.id!));
    final ruleItemRows = await ruleItemsQuery.get();
    final ruleItemList = ruleItemRows
        .map((row) => models.TypeAdapters.convertToRuleItem(row))
        .toList();

    return models.Rule(
      id: ruleRow.id,
      name: ruleRow.name,
      rules: ruleItemList,
      isSystemRule: ruleRow.isSystemRule,
    );
  }

  Future<models.Rule> getRuleByName(String name) async {
    // 查找规则
    final ruleQuery = _db.select(_db.ruleEntities)..where((tbl) => tbl.name.equals(name));
    var ruleRow = await ruleQuery.getSingleOrNull();

    if (ruleRow == null) {
      // 根据设计，规则组应该由 ensureRuleGroupExists 创建，
      // 或者至少有一个默认的 fallback (例如 'custom' 组)
      // 为避免意外，如果未找到，可以返回一个空的自定义规则组或抛出错误
      // 这里我们假设它应该存在，或按需创建
      if (name == models.Rule.customRuleName) {
        return await ensureRuleGroupExists(name, isSystemRule: false);
      } else if (name == models.Rule.recommendRuleName) {
         return await ensureRuleGroupExists(name, isSystemRule: true);
      }
      // Fallback to an empty rule if not a known default, though this path should ideally not be hit often
      print("Warning: Rule group '$name' not found and not a default. Returning empty rule.");
      return models.Rule(name: name, rules: [], isSystemRule: false);
    }

    // 获取规则项
    final ruleItemsQuery = _db.select(_db.ruleItemEntities)..where((tbl) => tbl.ruleId.equals(ruleRow.id!));
    final ruleItemRows = await ruleItemsQuery.get();

    final ruleItemList = ruleItemRows
        .map((row) => models.TypeAdapters.convertToRuleItem(row))
        .toList();

    return models.Rule(
        id: ruleRow.id,
        name: ruleRow.name,
        rules: ruleItemList,
        isSystemRule: ruleRow.isSystemRule,
    );
  }

  Future<models.Rule> addRuleItem(String ruleName, models.RuleItem ruleItem) async {
    // 获取或创建规则组 (确保 isSystemRule 状态正确传递或从数据库读取)
    final ruleGroup = await getRuleByName(ruleName); // This will ensure group exists if it's a default one
                                                 // Or retrieve existing group with its isSystemRule flag.

    if (ruleGroup.id == null) {
      // This case should ideally be handled by getRuleByName ensuring the group exists.
      // If we reach here with a null id, it implies getRuleByName returned an empty, unsaved Rule object.
      // We need a valid ruleGroupId to insert a ruleItem.
      // Let's try to ensure it again, though this indicates a potential logic flaw above.
      final ensuredGroup = await ensureRuleGroupExists(ruleName, isSystemRule: (ruleName == models.Rule.recommendRuleName));
      ruleItem.ruleId = ensuredGroup.id;
    } else {
       ruleItem.ruleId = ruleGroup.id;
    }
    
    if (ruleItem.ruleId == null) {
        throw Exception("Failed to determine ruleId for rule group: $ruleName");
    }

    // 添加规则项
    await _db.into(_db.ruleItemEntities).insert(RuleItemEntitiesCompanion(
      ruleId: Value(ruleItem.ruleId!),
      path: Value(ruleItem.path),
      pathMatchType: Value(ruleItem.pathMatchType.index),
      tags: ruleItem.tags != null ? Value(jsonEncode(ruleItem.tags)) : const Value.absent(),
      priority: Value(ruleItem.priority),
      enabled: Value(ruleItem.enabled),
      triggerCount: Value(ruleItem.triggerCount),
      lastTriggeredAt: ruleItem.lastTriggeredAt != null ? Value(ruleItem.lastTriggeredAt) : const Value.absent(),
      actionType: Value(ruleItem.actionType.index),
      annotation: Value(ruleItem.annotation),
    ));

    return await getRuleByName(ruleName); // Return the updated rule group
  }

  Future<List<models.Whitelist>> getAllWhitelists() async {
    final query = _db.select(_db.whitelistEntities);
    final results = await query.get();
    return results
        .map((row) => models.Whitelist(
              id: row.id,
              path: row.path,
              type: models.WhitelistType.values[row.type],
              annotation: row.annotation,
              readOnly: row.readOnly,
              createdAt: row.createdAt,
              updatedAt: row.updatedAt,
            ))
        .toList();
  }

  Future<bool> whitelistContains(String path) async {
    final query = _db.select(_db.whitelistEntities)..where((tbl) => tbl.path.equals(path.toLowerCase()));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  Future<models.Whitelist?> addWhitelist(models.Whitelist whitelist) async {
    if (await whitelistContains(whitelist.path)) {
      return null;
    }

    final companion = WhitelistEntitiesCompanion(
      path: Value(whitelist.path.toLowerCase()),
      type: Value(whitelist.type.index),
      annotation: Value(whitelist.annotation),
      readOnly: Value(whitelist.readOnly),
    );
    final newId = await _db.into(_db.whitelistEntities).insert(companion);
    
    // Return the created whitelist with its ID and db-generated dates
    final newWhitelistEntity = await (_db.select(_db.whitelistEntities)..where((tbl) => tbl.id.equals(newId))).getSingle();
    return whitelist.copyWith(
        id: newId,
        createdAt: newWhitelistEntity.createdAt,
        updatedAt: newWhitelistEntity.updatedAt,
    );
  }

  Future<void> deleteWhitelist(String path) async {
    await (_db.delete(_db.whitelistEntities)..where((tbl) => tbl.path.equals(path.toLowerCase()))).go();
  }

  Future<bool> hasRule(String path) async {
    final query = _db.select(_db.ruleItemEntities)
      ..where((tbl) => tbl.path.equals(path) & tbl.enabled.equals(true));
    final result = await query.get();
    return result.isNotEmpty;
  }

  Future<List<models.History>> getAllHistories() async {
    final query = _db.select(_db.historyEntities)..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);
    final results = await query.get();
    return results
        .map((row) => models.TypeAdapters.convertToHistory(row))
        .toList();
  }

  Future<models.History> addHistory(models.History history) async {
    final companion = HistoryEntitiesCompanion(
      name: Value(history.name),
      path: Value(history.path),
      time: Value(history.time),
      actionType: Value(history.actionType.index),
      spaceChange: history.spaceChange != null ? Value(history.spaceChange) : const Value.absent(),
      ruleId: history.ruleId != null ? Value(history.ruleId) : const Value.absent(),
      status: Value(history.status.index),
    );
    final newId = await _db.into(_db.historyEntities).insert(companion);
    final newHistoryEntity = await (_db.select(_db.historyEntities)..where((tbl) => tbl.id.equals(newId))).getSingle();
    return models.TypeAdapters.convertToHistory(newHistoryEntity);
  }

  Future<void> clearAllHistory() async {
    await _db.delete(_db.historyEntities).go();
  }

  Future<List<models.Rule>> getAllRuleGroups() async {
    final ruleGroupRows = await _db.select(_db.ruleEntities).get();
    final List<models.Rule> ruleGroups = [];
    for (var groupRow in ruleGroupRows) {
      final itemsQuery = _db.select(_db.ruleItemEntities)..where((tbl) => tbl.ruleId.equals(groupRow.id!));
      final itemRows = await itemsQuery.get();
      final ruleItems = itemRows.map((itemRow) => models.TypeAdapters.convertToRuleItem(itemRow)).toList();
      ruleGroups.add(models.Rule(
        id: groupRow.id,
        name: groupRow.name,
        rules: ruleItems,
        isSystemRule: groupRow.isSystemRule
      ));
    }
    return ruleGroups;
  }

  Future<void> updateRuleItem(models.RuleItem ruleItem) async {
    if (ruleItem.id == null) throw Exception("RuleItem ID cannot be null for update.");
    await (_db.update(_db.ruleItemEntities)..where((tbl) => tbl.id.equals(ruleItem.id!)))
        .write(RuleItemEntitiesCompanion(
            path: Value(ruleItem.path),
            pathMatchType: Value(ruleItem.pathMatchType.index),
            tags: ruleItem.tags != null ? Value(jsonEncode(ruleItem.tags)) : const Value.absent(),
            priority: Value(ruleItem.priority),
            enabled: Value(ruleItem.enabled),
            triggerCount: Value(ruleItem.triggerCount),
            lastTriggeredAt: ruleItem.lastTriggeredAt != null ? Value(ruleItem.lastTriggeredAt) : const Value.absent(),
            actionType: Value(ruleItem.actionType.index),
            annotation: Value(ruleItem.annotation),
        ));
  }

  Future<void> deleteRuleItem(int ruleItemId) async {
    await (_db.delete(_db.ruleItemEntities)..where((tbl) => tbl.id.equals(ruleItemId))).go();
  }
  
  Future<void> deleteRuleGroup(int ruleGroupId) async {
    await (_db.delete(_db.ruleEntities)..where((tbl) => tbl.id.equals(ruleGroupId))).go();
  }

  Future<void> updateRuleGroup(models.Rule ruleGroup) async {
    if (ruleGroup.id == null) throw Exception("RuleGroup ID cannot be null for update.");
    await (_db.update(_db.ruleEntities)..where((tbl) => tbl.id.equals(ruleGroup.id!)))
        .write(RuleEntitiesCompanion(
            name: Value(ruleGroup.name),
            isSystemRule: Value(ruleGroup.isSystemRule),
        ));
  }
}
