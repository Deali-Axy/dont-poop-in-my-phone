import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // 隐藏状态栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    Future.delayed(Duration(seconds: 1)).then((e) {
      if (Global.firstRun)
        Navigator.of(context).pushReplacementNamed('introview');
      else
        Navigator.of(context).pushReplacementNamed('home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('assets/icon/icon.png'));
  }
}
