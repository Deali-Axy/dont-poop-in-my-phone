import 'package:flutter/material.dart';
import 'package:dont_poop_in_my_phone/widgets/cat_themed_app_bar.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CatThemedAppBar(
        title: '使用帮助',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 16),
            _buildQuickStartCard(),
            const SizedBox(height: 16),
            _buildFeaturesCard(),
            const SizedBox(height: 16),
            _buildSafetyCard(),
            const SizedBox(height: 16),
            _buildTipsCard(),
            const SizedBox(height: 16),
            _buildFAQCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.pets, color: Colors.orange, size: 28),
                const SizedBox(width: 8),
                const Text(
                  '欢迎使用扫地喵',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '扫地喵是一款专为安卓用户设计的智能垃圾清理工具。与传统清理软件不同，扫地喵不仅可以识别并清理常见的垃圾目录，还能自动在清理后为这些目录创建"只读替身"，防止流氓应用反复生成垃圾文件。',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStartCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.rocket_launch, color: Colors.blue, size: 28),
                const SizedBox(width: 8),
                const Text(
                  '快速上手',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildStepItem('1', '授权存储权限', '首次使用需要授权存储访问权限，以便扫描和清理垃圾文件'),
            _buildStepItem('2', '开始自动清理', '点击侧边栏的"自动清理"，扫地喵会自动扫描并显示可清理的垃圾目录'),
            _buildStepItem('3', '选择清理项目', '查看扫描结果，选择需要清理的目录，点击"开始清理"'),
            _buildStepItem('4', '查看清理结果', '清理完成后可在"历史记录"中查看详细的清理日志'),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(String step, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                step,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 28),
                const SizedBox(width: 8),
                const Text(
                  '主要功能',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildFeatureItem(Icons.cleaning_services, '智能清理', '自动识别常见垃圾目录，一键清理释放空间'),
            _buildFeatureItem(Icons.shield, '防止再生', '清理后创建只读替身，防止垃圾文件重新生成'),
            _buildFeatureItem(Icons.rule, '自定义规则', '创建个性化清理规则，精准控制清理范围'),
            _buildFeatureItem(Icons.security, '白名单保护', '设置白名单保护重要文件，确保安全'),
            _buildFeatureItem(Icons.history, '操作记录', '详细的清理日志，所有操作透明可控'),
            _buildFeatureItem(Icons.label, '路径标注', '为常用路径添加备注，方便识别和管理'),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.verified_user, color: Colors.green, size: 28),
                const SizedBox(width: 8),
                const Text(
                  '安全保障',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSafetyItem('内置白名单', '系统重要目录已预设保护，不会被误删'),
            _buildSafetyItem('操作确认', '重要操作前会弹出确认对话框'),
            _buildSafetyItem('详细日志', '所有操作都有详细记录，可随时查看'),
            _buildSafetyItem('权限控制', '仅请求必要的存储权限，保护隐私'),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.orange, size: 28),
                const SizedBox(width: 8),
                const Text(
                  '使用技巧',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTipItem('定期清理', '建议每周进行一次自动清理，保持手机存储空间充足'),
            _buildTipItem('谨慎占坑', '只对确认无用的目录使用占坑功能，避免影响应用正常运行'),
            _buildTipItem('备份重要文件', '清理前建议备份重要文件，虽然有白名单保护但多一份保险'),
            _buildTipItem('查看日志', '定期查看历史记录，了解清理效果和系统状态'),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.tips_and_updates, color: Colors.orange, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.help_outline, color: Colors.purple, size: 28),
                const SizedBox(width: 8),
                const Text(
                  '常见问题',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildFAQItem(
              'Q: 扫地喵会删除我的重要文件吗？',
              'A: 不会。扫地喵内置了完善的白名单保护机制，系统重要目录和用户重要文件都会被保护。您也可以手动添加白名单。',
            ),
            _buildFAQItem(
              'Q: 什么是"只读替身"？',
              'A: 清理垃圾目录后，扫地喵会在原位置创建一个同名的只读文件，防止应用重新创建垃圾目录。',
            ),
            _buildFAQItem(
              'Q: 如何撤销清理操作？',
              'A: 可以在历史记录中查看清理详情，手动删除替身文件即可恢复原状态。',
            ),
            _buildFAQItem(
              'Q: 为什么有些目录无法清理？',
              'A: 可能是该目录在白名单中，或者没有足够的权限。请检查白名单设置和权限授权。',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}