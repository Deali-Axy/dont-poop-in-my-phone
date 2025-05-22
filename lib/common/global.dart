import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';
import 'package:dont_poop_in_my_phone/database/database_manager.dart';

abstract class Global {
  static late SharedPreferences _prefs;
  static late AppConfig _appConfig;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();

    // 初始化数据库
    await DatabaseManager.initialize();

    // 读取App配置（仅保留简单配置项，如主题设置）
    var configJson = _prefs.getString('config');
    if (configJson != null) {
      final configData = jsonDecode(configJson);
      _appConfig = AppConfig(history: []); // 历史记录现在从数据库读取
      _appConfig.darkMode = configData['darkMode'] ?? false;
      _appConfig.material3 = configData['material3'] ?? false;
      // whiteList 和 ruleList 现在从数据库读取，不再从SharedPreferences读取
      _appConfig.whiteList = [];
      _appConfig.ruleList = [];
    } else {
      _appConfig = AppConfig(history: []);
      _appConfig.darkMode = false;
      _appConfig.material3 = false;
      _appConfig.whiteList = [];
      _appConfig.ruleList = [];
    }
  }

  static AppConfig get appConfig {
    return _appConfig;
  }

  static void saveAppConfig() {
    // 只保存简单配置项到SharedPreferences
    final simpleConfig = {
      'darkMode': _appConfig.darkMode,
      'material3': _appConfig.material3,
    };
    _prefs.setString('config', jsonEncode(simpleConfig));
  }

  static bool get firstRun {
    if (_prefs.containsKey('firstRun'))
      return false;
    else
      return true;
  }

  static set firstRun(bool data) {
    if (data)
      _prefs.remove('firstRun');
    else
      _prefs.setBool('firstRun', false);
  }
}
