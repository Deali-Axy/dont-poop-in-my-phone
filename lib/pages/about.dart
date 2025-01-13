import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/common/update.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  bool isUpToDate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<PackageInfo> _loadPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadPackageInfo(),
      builder: (context, AsyncSnapshot<PackageInfo>? snapshot) {
        return _buildBody(snapshot?.data);
      },
    );
  }

  Widget _buildBody(PackageInfo? packageInfo) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              '别在我手机里拉屎',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('${packageInfo?.version} Build${packageInfo?.buildNumber} (${DateTime.now().toString()})'),
            const SizedBox(height: 10),
            const Text('清理流氓APP产生的垃圾，并且把坑占了，不让它们再生产垃圾！'),
            const SizedBox(height: 40),
            const Text('Design By: DealiAxy'),
            const SizedBox(height: 10),
            const Text('微信公众号：程序设计实验室'),
            const Divider(height: 40),
            TextButton.icon(
              icon: const Icon(Icons.details),
              label: const Text('功能介绍'),
              onPressed: () => Navigator.of(context).pushNamed('introview'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('反馈'),
              onPressed: () async {
                // 调用系统邮件客户端来反馈
                const url = 'mailto:feedback@deali.cn?subject=别在我手机里拉屎App反馈&body=反馈内容：';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  BotToast.showText(text: '无法启动邮件客户端');
                }
              },
            ),
            if (isUpToDate) const SizedBox(height: 10),
            if (isUpToDate) const Text('已经是最新版本'),
            if (!isUpToDate)
              TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('检查新版本'),
                onPressed: () async {
                  showLoading(context, text: '检查更新');
                  var hasUpdate = await AppUpdate.checkUpdate(context);
                  Navigator.of(context).pop();
                  if (!hasUpdate) BotToast.showText(text: '已经是最新版本');
                  setState(() {
                    isUpToDate = true;
                  });
                },
              ),
            const Expanded(child: Text('')),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                    child: const Text('软件许可'),
                    onPressed: () async {
                      var uri = Uri.parse('http://www.sblt.deali.cn:9000/APP许可协议.html');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        BotToast.showText(text: '无法启动浏览器');
                      }
                    }),
                TextButton(
                    child: const Text('用户隐私协议'),
                    onPressed: () async {
                      var uri = Uri.parse('http://www.sblt.deali.cn:9000/APP隐私政策.html');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        BotToast.showText(text: '无法启动浏览器');
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
