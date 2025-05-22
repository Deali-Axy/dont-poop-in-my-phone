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
  TextColumn get annotation => text().withDefault(const Constant(''))();
  BoolColumn get readOnly => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 规则表
class RuleEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// 规则项表
class RuleItemEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ruleId => integer().references(RuleEntities, #id, onDelete: KeyAction.cascade)();
  TextColumn get path => text()();
  IntColumn get actionType => integer()(); // 对应 ActionType enum
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
  IntColumn get actionType => integer()(); // 对应 ActionType enum
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [WhitelistEntities, RuleEntities, RuleItemEntities, HistoryEntities])
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
