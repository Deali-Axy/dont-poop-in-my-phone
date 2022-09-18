import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Global {
  static SharedPreferences _prefs;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
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
