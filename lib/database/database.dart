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
class WhitelistEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text()();
  IntColumn get type => integer().withDefault(const Constant(0))();
  TextColumn get annotation => text().withDefault(const Constant(''))();
  BoolColumn get readOnly => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 规则表
class RuleEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  BoolColumn get isSystemRule => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 规则项表
class RuleItemEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ruleId => integer().references(RuleEntities, #id, onDelete: KeyAction.cascade)();
  TextColumn get path => text()();
  IntColumn get pathMatchType => integer()();
  TextColumn get tags => text().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  IntColumn get triggerCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastTriggeredAt => dateTime().nullable()();
  IntColumn get actionType => integer()();
  TextColumn get annotation => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 历史记录表
class HistoryEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get path => text()();
  DateTimeColumn get time => dateTime()();
  IntColumn get actionType => integer()();
  IntColumn get spaceChange => integer().nullable()();
  IntColumn get ruleId => integer().nullable().references(RuleItemEntities, #id, onDelete: KeyAction.setNull)();
  IntColumn get status => integer().withDefault(Constant(models.HistoryStatus.success.index))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [WhitelistEntities, RuleEntities, RuleItemEntities, HistoryEntities])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.addColumn(ruleEntities, ruleEntities.isSystemRule);
            await m.addColumn(ruleItemEntities, ruleItemEntities.pathMatchType);
            await m.addColumn(ruleItemEntities, ruleItemEntities.tags);
            await m.addColumn(ruleItemEntities, ruleItemEntities.priority);
            await m.addColumn(ruleItemEntities, ruleItemEntities.enabled);
            await m.addColumn(ruleItemEntities, ruleItemEntities.triggerCount);
            await m.addColumn(ruleItemEntities, ruleItemEntities.lastTriggeredAt);
          }
          if (from < 3) {
            await m.addColumn(whitelistEntities, whitelistEntities.type);
          }
          if (from < 4) {
            await m.addColumn(historyEntities, historyEntities.spaceChange);
            await m.addColumn(historyEntities, historyEntities.ruleId);
            await m.addColumn(historyEntities, historyEntities.status);
          }
        },
      );
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
