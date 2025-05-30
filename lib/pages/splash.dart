import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // 使用全局的边到边显示配置，不在此处覆盖

    Future.delayed(Duration(seconds: 1)).then((e) {
      if (Global.firstRun)
        Navigator.of(context).pushReplacementNamed('introview');
      else
        Navigator.of(context).pushReplacementNamed('home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 背景图
          Positioned.fill(child: Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
          )),
        ],
      ),
    );
  }
}
