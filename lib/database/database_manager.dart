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
      await _initializeDefaultWhitelist();
    }
  }

  /// 初始化默认白名单
  static Future<void> _initializeDefaultWhitelist() async {
    // 检查是否已有默认白名单
    final existingWhitelists = await _service.getAllWhitelists();
    if (existingWhitelists.isNotEmpty) {
      return;
    }

    // 添加默认白名单
    for (final path in StarFileSystem.PATH_WHITE_LIST) {
      final whitelist = models.Whitelist(path: path, annotation: '[内置规则]系统/重要文件目录', readOnly: true);
      await _service.addWhitelist(whitelist);
    }
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

  Future<models.Rule> getRuleByName(String name) async {
    // 查找规则
    final ruleQuery = _db.select(_db.ruleEntities)..where((tbl) => tbl.name.equals(name));
    var ruleRow = await ruleQuery.getSingleOrNull();

    if (ruleRow == null) {
      // 创建新规则
      await _db.into(_db.ruleEntities).insert(RuleEntitiesCompanion(
        name: Value(name),
      ));
      return models.Rule(name: name, rules: []);
    }

    // 获取规则项
    final ruleItemsQuery = _db.select(_db.ruleItemEntities)..where((tbl) => tbl.ruleId.equals(ruleRow.id!));
    final ruleItemRows = await ruleItemsQuery.get();

    final ruleItemList = ruleItemRows
        .map((row) => models.TypeAdapters.convertToRuleItem(row))
        .toList();

    return models.Rule(id: ruleRow.id, name: name, rules: ruleItemList);
  }

  Future<models.Rule> addRuleItem(String ruleName, models.RuleItem ruleItem) async {
    // 获取或创建规则
    final ruleQuery = _db.select(_db.ruleEntities)..where((tbl) => tbl.name.equals(ruleName));
    var ruleRow = await ruleQuery.getSingleOrNull();

    if (ruleRow == null) {
      final ruleId = await _db.into(_db.ruleEntities).insert(RuleEntitiesCompanion(
        name: Value(ruleName),
      ));
      ruleRow = await (_db.select(_db.ruleEntities)..where((tbl) => tbl.id.equals(ruleId))).getSingle();
    }

    // 添加规则项
    await _db.into(_db.ruleItemEntities).insert(RuleItemEntitiesCompanion(
      ruleId: Value(ruleRow.id!),
      path: Value(ruleItem.path),
      actionType: Value(ruleItem.actionType.toInt()),
      annotation: Value(ruleItem.annotation),
    ));

    return await getRuleByName(ruleName);
  }

  Future<List<models.Whitelist>> getAllWhitelists() async {
    final query = _db.select(_db.whitelistEntities);
    final results = await query.get();
    return results
        .map((row) => models.Whitelist(
              path: row.path,
              annotation: row.annotation,
              readOnly: row.readOnly,
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

    await _db.into(_db.whitelistEntities).insert(WhitelistEntitiesCompanion(
      path: Value(whitelist.path.toLowerCase()),
      annotation: Value(whitelist.annotation),
      readOnly: Value(whitelist.readOnly),
    ));

    return whitelist;
  }

  Future<void> deleteWhitelist(String path) async {
    await (_db.delete(_db.whitelistEntities)..where((tbl) => tbl.path.equals(path))).go();
  }

  Future<bool> hasRule(String path) async {
    final defaultRule = await getRuleByName(models.Rule.defaultRuleName);
    return defaultRule.rules.any((e) => e.path == path);
  }

  Future<List<models.History>> getAllHistories() async {
    final query = _db.select(_db.historyEntities)..orderBy([(tbl) => OrderingTerm.desc(tbl.time)]);
    final results = await query.get();
    return results
        .map((row) => models.TypeAdapters.convertToHistory(row))
        .toList();
  }

  Future<void> addHistory(models.History history) async {
    await _db.into(_db.historyEntities).insert(HistoryEntitiesCompanion(
      name: Value(history.name),
      path: Value(history.path),
      time: Value(history.time),
      actionType: Value(history.actionType.toInt()),
    ));
  }
}
