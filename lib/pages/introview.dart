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
      body: const Text(
        '欢迎使用扫地喵！\n\n扫地喵是一款专为安卓用户设计的智能垃圾清理工具，能够智能识别并清理常见的垃圾目录，快速释放手机存储空间。',
        textAlign: TextAlign.center,
      ),
      title: const Text('智能清理'),
      titleTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 16),
      mainImage: Icon(Icons.cleaning_services_outlined, size: 200, color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      body: const Text(
        '防止垃圾再生\n\n清理后自动创建"只读替身"文件，防止流氓应用反复在相同位置生成垃圾文件，从根源解决问题。',
        textAlign: TextAlign.center,
      ),
      title: const Text('智能占坑'),
      mainImage: Icon(Icons.shield_outlined, size: 200, color: Colors.white),
      titleTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 16),
    ),
    PageViewModel(
      pageColor: const Color(0xFF2B5641),
      body: const Text(
        '自定义规则\n\n支持创建个性化清理规则，设置白名单保护重要文件，让清理更精准、更安全。',
        textAlign: TextAlign.center,
      ),
      title: const Text('智能规则'),
      mainImage: Icon(Icons.rule, size: 200, color: Colors.white),
      titleTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 16),
    ),
    PageViewModel(
      pageColor: const Color(0xFFFF6B35),
      body: const Text(
        '安全保障\n\n内置安全机制和白名单保护，确保系统稳定，不会误删重要文件。所有操作都有详细日志记录。',
        textAlign: TextAlign.center,
      ),
      title: const Text('安全可靠'),
      mainImage: Icon(Icons.security, size: 200, color: Colors.white),
      titleTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 16),
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
              Color(0xFF6A4C93),
              Color(0xFF9B59B6),
            ],
          ),
        ),
      ),
      body: const Text(
        '开始使用\n\n现在您可以开始使用扫地喵了！建议先查看帮助页面了解详细功能，然后从自动清理开始体验。',
        textAlign: TextAlign.center,
      ),
      title: const Text('准备就绪'),
      mainImage: Icon(Icons.rocket_launch, size: 200, color: Colors.white),
      titleTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 16),
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
