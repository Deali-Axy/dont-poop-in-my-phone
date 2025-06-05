import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../common/global.dart';

class UserAgreementPage extends StatefulWidget {
  const UserAgreementPage({Key? key}) : super(key: key);

  @override
  _UserAgreementPageState createState() => _UserAgreementPageState();
}

class _UserAgreementPageState extends State<UserAgreementPage>
    with TickerProviderStateMixin {
  bool _agreementAccepted = false;
  bool _privacyAccepted = false;
  late AnimationController _catAnimationController;
  late Animation<double> _catBounceAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _catAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _catBounceAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _catAnimationController,
      curve: Curves.easeInOut,
    ));
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
    
    _catAnimationController.repeat(reverse: true);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _catAnimationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF86E5CE); // 薄荷绿主色
    final accentColor = const Color(0xFF00A693); // 深薄荷绿
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF5FFFE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        title: Row(
          children: [
            AnimatedBuilder(
              animation: _catBounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_catBounceAnimation.value),
                  child: const Text(
                    '🐱',
                    style: TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            const Text(
              '用户协议与隐私政策',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 欢迎卡片
                    _buildWelcomeCard(primaryColor, accentColor, isDark),
                    const SizedBox(height: 20),
                    
                    // 权限说明卡片
                    _buildPermissionCard(primaryColor, accentColor, isDark),
                    const SizedBox(height: 20),

                    // 用户协议
                    _buildAgreementSection(
                      '📋 用户协议',
                      _getAgreementContent(),
                      _agreementAccepted,
                      (value) =>
                          setState(() => _agreementAccepted = value ?? false),
                      primaryColor,
                      accentColor,
                      isDark,
                    ),

                    const SizedBox(height: 20),

                    // 隐私政策
                    _buildAgreementSection(
                      '🔒 隐私政策',
                      _getPrivacyContent(),
                      _privacyAccepted,
                      (value) =>
                          setState(() => _privacyAccepted = value ?? false),
                      primaryColor,
                      accentColor,
                      isDark,
                    ),
                  ],
                ),
              ),
            ),

            // 底部按钮
            _buildBottomButtons(primaryColor, accentColor, isDark),
          ],
        ),
      ),
    );
  }

  // 欢迎卡片
  Widget _buildWelcomeCard(Color primaryColor, Color accentColor, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.1),
            accentColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Color.fromRGBO(134, 229, 206, 1),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Image.asset('assets/icon/icon.png'),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                '欢迎使用扫地喵！',
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            totalRepeatCount: 1,
          ),
          const SizedBox(height: 12),
          Text(
            '为了给您提供更好的服务体验\n请仔细阅读以下协议内容',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // 权限说明卡片
  Widget _buildPermissionCard(Color primaryColor, Color accentColor, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '🔐',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '权限说明',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildPermissionItem(
            '📁',
            '存储权限',
            '用于扫描并清理垃圾文件，这是应用的核心功能',
            true,
            primaryColor,
            isDark,
          ),
          const SizedBox(height: 16),
          _buildPermissionItem(
            '🎈',
            '悬浮窗权限',
            '用于展示清理进度提示（可选）',
            false,
            primaryColor,
            isDark,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withOpacity(0.1),
                  accentColor.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: primaryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Text(
                  '🛡️',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '所有数据处理均在本地完成，不会上传任何个人信息',
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionItem(
    String emoji,
    String title,
    String description,
    bool required,
    Color primaryColor,
    bool isDark,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  if (required) const SizedBox(width: 8),
                  if (required)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        '必需',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAgreementSection(
    String title,
    String content,
    bool isAccepted,
    ValueChanged<bool?> onChanged,
    Color primaryColor,
    Color accentColor,
    bool isDark,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
          ),
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark 
                  ? Colors.grey[800] 
                  : primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: primaryColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: SingleChildScrollView(
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isAccepted 
                  ? primaryColor.withOpacity(0.1) 
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isAccepted 
                    ? primaryColor 
                    : Colors.grey.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              title: Text(
                '我已阅读并同意${title.replaceAll(RegExp(r'[📋🔒]\s*'), '')}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              value: isAccepted,
              onChanged: onChanged,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: accentColor,
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(Color primaryColor, Color accentColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  // 不同意，退出应用
                  SystemNavigator.pop();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '😔',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '不同意',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 50,
              child: ElevatedButton(
                onPressed: (_agreementAccepted && _privacyAccepted)
                    ? () {
                        // 同意协议，标记已接受并继续
                        Global.agreementAccepted = true;
                        if (Global.firstRun) {
                          Navigator.of(context)
                              .pushReplacementNamed('introview');
                        } else {
                          Navigator.of(context)
                              .pushReplacementNamed('home');
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: (_agreementAccepted && _privacyAccepted)
                      ? accentColor
                      : Colors.grey.shade300,
                  foregroundColor: Colors.white,
                  elevation: (_agreementAccepted && _privacyAccepted) ? 4 : 0,
                  shadowColor: accentColor.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (_agreementAccepted && _privacyAccepted) ? '🎉' : '⏳',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '同意并继续',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getAgreementContent() {
    return '''欢迎使用"扫地喵"应用！

请在使用本应用前仔细阅读以下条款，一旦您开始使用本应用，即视为您已同意本协议全部内容。

一、服务说明

1. "扫地喵"是一款Android平台上的清理工具，主要功能包括：识别垃圾文件、清理无用数据、创建保护性只读文件以防止垃圾文件重复生成等。
2. 本应用致力于为用户提供更流畅、更洁净的设备使用体验，不包含任何违法或恶意操作行为。

二、用户权利与义务

1. 用户有权免费使用本应用的基础功能（如有收费项目，将在使用前明确告知）。
2. 用户不得将本应用用于任何非法用途，包括但不限于恶意攻击、信息窃取、破解其他应用等行为。
3. 用户应自行负责其设备数据的备份与恢复，本应用对因清理操作造成的误删、系统异常不承担责任（我们将尽最大努力规避此类问题）。

三、软件更新

1. 我们可能会不定期提供软件更新，以优化性能、修复问题或提供新功能。
2. 用户同意我们在必要时进行自动或提示性更新。

四、免责声明

1. 本应用通过常规逻辑识别和清理无用文件，但因设备环境复杂，不能保证100%准确。
2. 若用户在使用过程中因第三方应用变更行为造成异常，我们不承担责任。

五、其他

1. 本协议未尽事项，依据《中华人民共和国民法典》《网络安全法》等相关法律法规执行。
2. 若您对本协议有任何疑问，可通过邮箱：feedback@deali.cn 与我们联系。''';
  }

  String _getPrivacyContent() {
    return '''我们非常重视您的隐私与数据安全。

本隐私政策旨在帮助您了解我们在使用"扫地喵"App时，如何收集、使用、存储和保护您的信息。

一、信息收集

我们不会主动收集或上传任何用户的个人身份信息（如姓名、手机号、地址、账号密码等）。

本应用可能会读取以下信息以实现核心功能：

- 设备存储中的文件路径及文件名（用于识别垃圾文件）
- 应用包名信息（用于识别流氓软件创建目录）
- Android版本、厂商型号（用于适配不同设备）

这些信息仅在本地设备中处理，不上传、不分享。

二、信息使用

我们收集的信息仅用于以下目的：

- 实现清理功能
- 提高应用兼容性和稳定性
- 用户体验优化与Bug修复

我们不会将您的任何信息用于广告推送、用户画像构建或与第三方共享。

三、权限申请说明

本应用可能申请以下权限：

- 存储权限：用于扫描并清理垃圾文件。
- 悬浮窗权限（可选）：用于展示清理进度提示。

所有权限的申请都将明确告知用户，并可自由选择是否授权。

四、数据存储与安全

- 本应用不会将数据上传至任何服务器。
- 所有处理均在本地完成，不存储用户数据。
- 对于用户自行生成的只读文件，我们不会做远程记录或干预。

五、第三方服务

本应用不嵌入任何第三方SDK（如广告、统计等），不会通过第三方渠道收集用户数据。

六、政策更新

本政策可能会因业务变更而不定期更新，变更后将在App内或官网（如有）公告，请您留意相关信息。

如果您有任何关于用户协议或隐私政策的疑问，请联系邮箱：feedback@deali.cn''';
  }
}
