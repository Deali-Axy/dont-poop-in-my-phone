import 'package:flutter/material.dart';
import 'package:dont_poop_in_my_phone/common/global.dart';

class UserAgreementPage extends StatefulWidget {
  const UserAgreementPage({Key? key}) : super(key: key);

  @override
  _UserAgreementPageState createState() => _UserAgreementPageState();
}

class _UserAgreementPageState extends State<UserAgreementPage> {
  bool _agreementAccepted = false;
  bool _privacyAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户协议与隐私政策'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 权限说明卡片
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.security, color: Colors.orange),
                              const SizedBox(width: 8),
                              Text(
                                '权限说明',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildPermissionItem(
                            Icons.folder,
                            '存储权限',
                            '用于扫描并清理垃圾文件，这是应用的核心功能',
                            true,
                          ),
                          const SizedBox(height: 8),
                          _buildPermissionItem(
                            Icons.picture_in_picture,
                            '悬浮窗权限',
                            '用于展示清理进度提示（可选）',
                            false,
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.info, color: Colors.blue),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '所有数据处理均在本地完成，不会上传任何个人信息',
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 用户协议
                  _buildAgreementSection(
                    '用户协议',
                    _getAgreementContent(),
                    _agreementAccepted,
                    (value) =>
                        setState(() => _agreementAccepted = value ?? false),
                  ),

                  const SizedBox(height: 16),

                  // 隐私政策
                  _buildAgreementSection(
                    '隐私政策',
                    _getPrivacyContent(),
                    _privacyAccepted,
                    (value) =>
                        setState(() => _privacyAccepted = value ?? false),
                  ),
                ],
              ),
            ),
          ),

          // 底部按钮
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // 不同意，退出应用
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey),
                    ),
                    child: const Text(
                      '不同意',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
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
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: const Text(
                      '同意并继续',
                      style: TextStyle(fontSize: 16),
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
      IconData icon, String title, String description, bool required) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  if (required) const SizedBox(width: 4),
                  if (required)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
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
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
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
  ) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: SingleChildScrollView(
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
          ),
          CheckboxListTile(
            title: Text('我已阅读并同意《$title》'),
            value: isAccepted,
            onChanged: onChanged,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.blue,
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
