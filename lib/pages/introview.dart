import 'package:dont_poop_in_my_phone/common/global.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class IntroViewPage extends StatelessWidget {
  IntroViewPage({Key? key}) : super(key: key);

  final mainImage = Image.asset(
    'assets/icon/icon.png',
    height: 285.0,
    width: 285.0,
    alignment: Alignment.center,
  );

  final pages = [
    PageViewModel(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',
      // bubble: Image.asset('assets/icon/icon.png'),
      body: const Text('清理流氓App在存储根目录里创建的垃圾文件夹'),
      title: const Text('清理'),
      titleTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      mainImage: Icon(Icons.cleaning_services_outlined, size: 285, color: const Color(0xFFACD8FF)),
    ),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      // iconImageAssetPath: 'assets/icon/icon.png',
      body: const Text('使用空白文件替换流氓App创建的垃圾文件夹'),
      title: const Text('占坑'),
      mainImage: Icon(Icons.do_not_disturb, size: 285, color: const Color(0xFFACD8FF)),
      titleTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFF2B5641),
      // iconImageAssetPath: 'assets/icon/icon.png',
      body: const Text('创建自定义的清理规则，自动清理'),
      title: const Text('规则'),
      mainImage: Icon(Icons.rule, size: 285, color: const Color(0xFFACD8FF)),
      titleTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageBackground: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
              Colors.orange,
              Colors.pinkAccent,
            ],
          ),
        ),
      ),
      // iconImageAssetPath: 'assets/icon/icon.png',
      body: const Text('搞清楚某个目录是没用的再使用占坑功能'),
      title: const Text('注意'),
      mainImage: Icon(Icons.warning, size: 285, color: const Color(0xFFACD8FF)),
      titleTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IntroViewsFlutter(
        pages,
        showNextButton: true,
        showBackButton: true,
        showSkipButton: false,
        backText: const Text('返回'),
        nextText: const Text('继续'),
        doneText: const Text('我知道了'),
        onTapDoneButton: () {
          Global.firstRun = false;
          // Use Navigator.pushReplacement if you want to dispose the latest route
          // so the user will not be able to slide back to the Intro Views.
          Navigator.of(context).pushReplacementNamed('home');
        },
        pageButtonTextStyles: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
