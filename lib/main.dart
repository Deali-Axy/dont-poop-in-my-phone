import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/global.dart';

void main() {
  Global.init().then((value) {
    runApp(MyApp());
  });

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    var systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '别在我的手机里拉屎！',
      theme: _getTheme(Brightness.light),
      darkTheme: _getTheme(Brightness.dark),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: SplashPage(),
      routes: {
        'about': (ctx) => AboutPage(),
        'history': (ctx) => HistoryPage(),
        'home': (ctx) => HomePage(),
        'introview': (ctx) => IntroViewPage(),
        'rule': (ctx) => RulePage(),
        'splash': (ctx) => SplashPage(),
        'white_list': (ctx) => WhitelistPage(),
      },
    );
  }

  ThemeData _getTheme(Brightness brightness){
    return ThemeData(
      brightness: brightness,
      colorSchemeSeed: const Color(0xff0763f5),
      useMaterial3: false,
    );
  }
}
