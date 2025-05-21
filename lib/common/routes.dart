import 'package:flutter/material.dart';
import '../pages/index.dart';

class AppRoutes {
  static const String home = 'home';
  static const String about = 'about';
  static const String clean = 'clean';
  static const String history = 'history';
  static const String introview = 'introview';
  static const String rule = 'rule';
  static const String splash = 'splash';
  static const String whitelist = 'white_list';
  
  static Map<String, WidgetBuilder> routes = {
    home: (ctx) => HomePage(),
    about: (ctx) => const AboutPage(),
    clean: (ctx) => const CleanPage(),
    history: (ctx) => const HistoryPage(),
    introview: (ctx) => IntroViewPage(),
    rule: (ctx) => const RulePage(),
    splash: (ctx) => SplashPage(),
    whitelist: (ctx) => const WhitelistPage(),
  };
  
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return null;
  }
} 