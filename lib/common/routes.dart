import 'package:flutter/material.dart';
import '../pages/index.dart';
import '../pages/permission_guide.dart';

class AppRoutes {
  static const String home = 'home';
  static const String about = 'about';
  static const String clean = 'clean';
  static const String history = 'history';
  static const String introview = 'introview';
  static const String rule = 'rule';
  static const String splash = 'splash';
  static const String whitelist = 'white_list';
  static const String debug = 'debug';
  static const String pathAnnotation = 'path_annotation';
  static const String userAgreement = 'user_agreement';
  static const String help = 'help';
  static const String configManagement = 'config_management';
  static const String permissionGuide = 'permission_guide';
  
  static Map<String, WidgetBuilder> routes = {
    home: (ctx) => HomePage(),
    about: (ctx) => const AboutPage(),
    clean: (ctx) => const CleanPage(),
    history: (ctx) => const HistoryPage(),
    introview: (ctx) => IntroViewPage(),
    rule: (ctx) => const RulePage(),
    splash: (ctx) => SplashPage(),
    whitelist: (ctx) => const WhitelistPage(),
    debug: (ctx) => const DebugPage(),
    pathAnnotation: (ctx) => const PathAnnotationPage(),
    userAgreement: (ctx) => const UserAgreementPage(),
    help: (ctx) => const HelpPage(),
    configManagement: (ctx) => const ConfigManagementPage(),
    permissionGuide: (ctx) => const PermissionGuidePage(),
  };
  
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return null;
  }
}