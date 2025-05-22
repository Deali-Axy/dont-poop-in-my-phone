import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

import '../models/index.dart' as models;

part 'database.g.dart';

// 白名单表
class Whitelists extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text()();
  TextColumn get annotation => text().withDefault(const Constant(''))();
  BoolColumn get readOnly => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 规则表
class Rules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 规则项表
class RuleItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ruleId => integer().references(Rules, #id, onDelete: KeyAction.cascade)();
  TextColumn get path => text()();
  IntColumn get actionType => integer()(); // 对应 ActionType enum
  TextColumn get annotation => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 历史记录表
class Histories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get path => text()();
  DateTimeColumn get time => dateTime()();
  IntColumn get actionType => integer()(); // 对应 ActionType enum
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Whitelists, Rules, RuleItems, Histories])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
      );

  // 白名单相关操作
  Future<List<models.Whitelist>> getAllWhitelists() async {
    final query = select(whitelists);
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
    final query = select(whitelists)..where((tbl) => tbl.path.equals(path.toLowerCase()));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  Future<models.Whitelist?> addWhitelist(models.Whitelist whitelist) async {
    if (await whitelistContains(whitelist.path)) {
      return null;
    }

    await into(whitelists).insert(WhitelistsCompanion(
      path: Value(whitelist.path.toLowerCase()),
      annotation: Value(whitelist.annotation),
      readOnly: Value(whitelist.readOnly),
    ));

    return whitelist;
  }

  Future<void> deleteWhitelist(String path) async {
    await (delete(whitelists)..where((tbl) => tbl.path.equals(path))).go();
  }

  // 规则相关操作
  Future<models.Rule> getRuleByName(String name) async {
    // 查找规则
    final ruleQuery = select(rules)..where((tbl) => tbl.name.equals(name));
    var ruleRow = await ruleQuery.getSingleOrNull();

    if (ruleRow == null) {
      // 创建新规则
      await into(rules).insert(RulesCompanion(
        name: Value(name),
      ));
      return models.Rule(name: name, rules: []);
    }

    // 获取规则项
    final ruleItemsQuery = select(ruleItems)..where((tbl) => tbl.ruleId.equals(ruleRow.id));
    final ruleItemRows = await ruleItemsQuery.get();

    final ruleItemList = ruleItemRows
        .map((row) => models.RuleItem(
              path: row.path,
              actionType: models.ActionType.values[row.actionType],
              annotation: row.annotation,
            ))
        .toList();

    return models.Rule(name: name, rules: ruleItemList);
  }

  Future<models.Rule> addRuleItem(String ruleName, models.RuleItem ruleItem) async {
    // 获取或创建规则
    final ruleQuery = select(rules)..where((tbl) => tbl.name.equals(ruleName));
    var ruleRow = await ruleQuery.getSingleOrNull();

    if (ruleRow == null) {
      final ruleId = await into(rules).insert(RulesCompanion(
        name: Value(ruleName),
      ));
      ruleRow = await (select(rules)..where((tbl) => tbl.id.equals(ruleId))).getSingle();
    }

    // 添加规则项
    await into(ruleItems).insert(RuleItemsCompanion(
      ruleId: Value(ruleRow.id),
      path: Value(ruleItem.path),
      actionType: Value(ruleItem.actionType.index),
      annotation: Value(ruleItem.annotation),
    ));

    return await getRuleByName(ruleName);
  }

  Future<bool> hasRule(String path) async {
    final defaultRule = await getRuleByName(models.Rule.defaultRuleName);
    return defaultRule.rules.any((e) => e.path == path);
  }

  // 历史记录相关操作
  Future<List<models.History>> getAllHistories() async {
    final query = select(histories)..orderBy([(tbl) => OrderingTerm.desc(tbl.time)]);
    final results = await query.get();
    return results
        .map((row) => models.History(
              name: row.name,
              path: row.path,
              time: row.time,
              actionType: models.ActionType.values[row.actionType],
            ))
        .toList();
  }

  Future<void> addHistory(models.History history) async {
    await into(histories).insert(HistoriesCompanion(
      name: Value(history.name),
      path: Value(history.path),
      time: Value(history.time),
      actionType: Value(history.actionType.index),
    ));
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.db'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
