import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dont_poop_in_my_phone/models/index.dart';

abstract class Global {
  static late SharedPreferences _prefs;
  static late AppConfig _appConfig;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();

    // 读取App配置
    var configJson = _prefs.getString('config');
    if (configJson != null) {
      _appConfig = AppConfig.fromJson(jsonDecode(configJson));
    } else {
      _appConfig = AppConfig.fromDefault();
    }
  }

  static AppConfig get appConfig {
    return _appConfig;
  }

  static void saveAppConfig() => _prefs.setString('config', jsonEncode(appConfig.toJson()));


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
