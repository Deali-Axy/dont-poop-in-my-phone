import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/index.dart' as models;
import '../utils/index.dart';
import 'database.dart';

class DatabaseManager {
  static AppDatabase? _database;
  static bool _migrated = false;

  static AppDatabase get database {
    _database ??= AppDatabase();
    return _database!;
  }

  /// 初始化数据库并进行数据迁移
  static Future<void> initialize() async {
    if (_migrated) return;

    final db = database;

    // 检查是否需要从SharedPreferences迁移数据
    await _migrateFromSharedPreferences();

    _migrated = true;
  }

  /// 从SharedPreferences迁移数据到数据库
  static Future<void> _migrateFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final configJson = prefs.getString('config');

    if (configJson == null) {
      // 没有旧数据，初始化默认白名单
      await _initializeDefaultWhitelist();
      return;
    }

    try {
      final configData = jsonDecode(configJson);
      final db = database;

      // 检查数据库是否已有数据
      final existingWhitelists = await db.getAllWhitelists();
      if (existingWhitelists.isNotEmpty) {
        // 数据库已有数据，跳过迁移
        return;
      }

      // 迁移白名单数据
      if (configData['whiteList'] != null) {
        final whitelistData = configData['whiteList'] as List;
        for (final item in whitelistData) {
          final whitelist = models.Whitelist.fromJson(item);
          await db.addWhitelist(whitelist);
        }
      }

      // 迁移规则数据
      if (configData['ruleList'] != null) {
        final ruleListData = configData['ruleList'] as List;
        for (final ruleData in ruleListData) {
          final rule = models.Rule.fromJson(ruleData);
          for (final ruleItem in rule.rules) {
            await db.addRuleItem(rule.name, ruleItem);
          }
        }
      }

      // 迁移历史记录数据
      if (configData['history'] != null) {
        final historyData = configData['history'] as List;
        for (final item in historyData) {
          final history = models.History.fromJson(item);
          await db.addHistory(history);
        }
      }

      print('数据迁移完成：从SharedPreferences迁移到数据库');

      // 迁移完成后，可以选择清除SharedPreferences中的旧数据
      // await prefs.remove('config');
    } catch (e) {
      print('数据迁移失败: $e');
      // 如果迁移失败，初始化默认白名单
      await _initializeDefaultWhitelist();
    }
  }

  /// 初始化默认白名单
  static Future<void> _initializeDefaultWhitelist() async {
    final db = database;

    // 检查是否已有默认白名单
    final existingWhitelists = await db.getAllWhitelists();
    if (existingWhitelists.isNotEmpty) {
      return;
    }

    // 添加默认白名单
    for (final path in StarFileSystem.PATH_WHITE_LIST) {
      final whitelist = models.Whitelist(path: path, annotation: '[内置规则]系统/重要文件目录', readOnly: true);
      await db.addWhitelist(whitelist);
    }
  }

  /// 关闭数据库连接
  static Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      _migrated = false;
    }
  }
}
