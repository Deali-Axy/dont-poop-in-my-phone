import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';

import 'states/index.dart';
import 'pages/index.dart';
import 'common/global.dart';
import 'common/routes.dart';
import 'utils/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 捕获全局Flutter错误
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    ErrorHandler().handleGeneralError(null, details.exception);
  };

  Global.init().then((value) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeState()),
        ],
        child: const MyApp(),
      ),
    );
  });

  if (Platform.isAndroid) {
    // 设置沉浸式样式
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 顶部状态栏透明
      systemNavigationBarColor: Colors.transparent, // 底部导航栏透明
      systemNavigationBarDividerColor: Colors.transparent, // 分隔线也透明
      systemNavigationBarIconBrightness: Brightness.light, // 图标颜色
      statusBarIconBrightness: Brightness.light, // 状态栏图标颜色
    ));

    // 设置内容全屏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '别在我的手机里拉屎！',
      theme: _getTheme(
        context.watch<ThemeState>().darkMode ? Brightness.dark : Brightness.light,
        context.watch<ThemeState>().material3,
      ),
      // 以前自适应系统暗色设置才开启的这个配置，现在改成手动
      // darkTheme: _getTheme(Brightness.dark),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: SplashPage(),
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }

  ThemeData _getTheme(Brightness brightness, bool useMaterial3) {
    const primaryColor = Color(0xff0763f5);

    if (useMaterial3) {
      const md3Theme = MaterialTheme(TextTheme());
      return brightness == Brightness.light ? md3Theme.light() : md3Theme.dark();
    }

    return ThemeData(
      useMaterial3: false,
      brightness: brightness,
      colorSchemeSeed: primaryColor,
    );
  }
}
