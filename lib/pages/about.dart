import 'package:bot_toast/bot_toast.dart';
import 'package:dont_poop_in_my_phone/common/update.dart';
import 'package:dont_poop_in_my_phone/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于应用'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 顶部标题部分
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/icon/icon.png'),
                    ),
                  ),
                  const SizedBox(height: 16),
            const Text(
              '别在我手机里拉屎',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
            ),
                  const SizedBox(height: 8),
                  Text(
                    '${packageInfo?.version} (Build ${packageInfo?.buildNumber})',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '清理流氓APP产生的垃圾，并且把坑占了，不让它们再生产垃圾！',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            // 中间详情部分
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(
                    title: '开发者信息',
                    children: [
                      _buildInfoRow(icon: Icons.person, text: 'DealiAxy'),
                      _buildInfoRow(icon: Icons.chat, text: '微信公众号：程序设计实验室'),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  _buildInfoCard(
                    title: '应用功能',
                    children: [
                      _buildActionButton(
                        icon: Icons.help_outline,
                        text: '功能介绍',
                        onTap: () => Navigator.of(context).pushNamed('introview'),
            ),
                      _buildActionButton(
                        icon: Icons.send,
                        text: '意见反馈',
                        onTap: () async {
                const url = 'mailto:feedback@deali.cn?subject=别在我手机里拉屎App反馈&body=反馈内容：';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  BotToast.showText(text: '无法启动邮件客户端');
                }
              },
            ),
                      _buildActionButton(
                        icon: isUpToDate ? Icons.check_circle_outline : Icons.refresh,
                        text: isUpToDate ? '已是最新版本' : '检查更新',
                        onTap: isUpToDate 
                            ? null 
                            : () async {
                  showLoading(context, text: '检查更新');
                  var hasUpdate = await AppUpdate.checkUpdate(context);
                  Navigator.of(context).pop();
                                if (!hasUpdate) {
                                  BotToast.showText(text: '已经是最新版本');
                  setState(() {
                    isUpToDate = true;
                  });
                                }
                },
              ),
                    ],
                  ),
                ],
              ),
            ),
            
            // 底部隐私条款部分
            Divider(color: Colors.grey.withOpacity(0.3), height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                  TextButton.icon(
                    icon: Icon(Icons.gavel, size: 18, color: Theme.of(context).colorScheme.primary),
                    label: const Text('软件许可'),
                    onPressed: () async {
                      var uri = Uri.parse('http://www.sblt.deali.cn:9000/APP许可协议.html');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        BotToast.showText(text: '无法启动浏览器');
                      }
                    },
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.privacy_tip, size: 18, color: Theme.of(context).colorScheme.primary),
                    label: const Text('隐私政策'),
                    onPressed: () async {
                      var uri = Uri.parse('http://www.sblt.deali.cn:9000/APP隐私政策.html');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        BotToast.showText(text: '无法启动浏览器');
                      }
                    },
                  ),
              ],
            ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '© ${DateTime.now().year} DealiAxy',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.withOpacity(0.7),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: onTap == null 
            ? Colors.green 
            : Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      enabled: onTap != null,
    );
  }
}
