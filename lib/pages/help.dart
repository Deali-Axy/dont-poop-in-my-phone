import 'package:flutter/material.dart';
import 'package:dont_poop_in_my_phone/widgets/cat_themed_app_bar.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CatThemedAppBar(
        title: '使用帮助',
        showBackButton: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).brightness == Brightness.dark ? null : LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade50,
              Colors.pink.shade50,
              Colors.purple.shade50,
            ],
          ),
          color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).colorScheme.surface : null,
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeCard(),
                  const SizedBox(height: 20),
                  _buildQuickStartCard(),
                  const SizedBox(height: 20),
                  _buildFeaturesCard(),
                  const SizedBox(height: 20),
                  _buildSafetyCard(),
                  const SizedBox(height: 20),
                  _buildTipsCard(),
                  const SizedBox(height: 20),
                  _buildFAQCard(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? null : LinearGradient(
          colors: [Colors.orange.shade100, Colors.pink.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: isDark ? Theme.of(context).colorScheme.surfaceContainer : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.orange).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? Theme.of(context).colorScheme.surface : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: (isDark ? Colors.black : Colors.orange).withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    '🐱',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '欢迎使用扫地喵',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Theme.of(context).colorScheme.onSurface : Colors.orange,
                        ),
                      ),
                      Text(
                        '让手机更清爽 🧹',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Theme.of(context).colorScheme.onSurface.withOpacity(0.8) : Colors.orange.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark 
                    ? Theme.of(context).colorScheme.surface.withOpacity(0.8)
                    : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '扫地喵是一款专为安卓用户设计的智能垃圾清理工具。与传统清理软件不同，扫地喵不仅可以识别并清理常见的垃圾目录，还能自动在清理后为这些目录创建"只读替身"，防止流氓应用反复生成垃圾文件。',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: isDark ? Theme.of(context).colorScheme.onSurface : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStartCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).colorScheme.surfaceContainer : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade600],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.rocket_launch,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '快速上手',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Theme.of(context).colorScheme.onSurface : Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildStepItem('1', '授权存储权限', '首次使用需要授权存储访问权限，以便扫描和清理垃圾文件', '🔐'),
            _buildStepItem('2', '开始自动清理', '点击侧边栏的"自动清理"，扫地喵会自动扫描并显示可清理的垃圾目录', '🔍'),
            _buildStepItem('3', '选择清理项目', '查看扫描结果，选择需要清理的目录，点击"开始清理"', '✅'),
            _buildStepItem('4', '查看清理结果', '清理完成后可在"历史记录"中查看详细的清理日志', '📊'),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(String step, String title, String description, String emoji) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).colorScheme.surface : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
              ? Theme.of(context).colorScheme.outline.withOpacity(0.3)
              : Colors.blue.shade100,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.blue.shade500],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                step,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      emoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Theme.of(context).colorScheme.onSurface : Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark 
                        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                        : Colors.grey[700],
                    height: 1.5,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).colorScheme.surfaceContainer : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber.shade400, Colors.orange.shade500],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '主要功能',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Theme.of(context).colorScheme.onSurface : Colors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildFeatureGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureGrid() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final features = [
      {'icon': '🧹', 'title': '智能清理', 'desc': '自动识别常见垃圾目录，一键清理释放空间', 'color': Colors.green},
      {'icon': '🛡️', 'title': '防止再生', 'desc': '清理后创建只读替身，防止垃圾文件重新生成', 'color': Colors.blue},
      {'icon': '⚙️', 'title': '自定义规则', 'desc': '创建个性化清理规则，精准控制清理范围', 'color': Colors.purple},
      {'icon': '🔒', 'title': '白名单保护', 'desc': '设置白名单保护重要文件，确保安全', 'color': Colors.orange},
      {'icon': '📝', 'title': '操作记录', 'desc': '详细的清理日志，所有操作透明可控', 'color': Colors.teal},
      {'icon': '🏷️', 'title': '路径标注', 'desc': '为常用路径添加备注，方便识别和管理', 'color': Colors.pink},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: isDark ? null : LinearGradient(
              colors: [
                (feature['color'] as MaterialColor).shade50,
                (feature['color'] as MaterialColor).shade100,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: isDark ? Theme.of(context).colorScheme.surface : null,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark 
                  ? Theme.of(context).colorScheme.outline.withOpacity(0.3)
                  : (feature['color'] as MaterialColor).shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feature['icon'] as String,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 8),
              Text(
                feature['title'] as String,
                style: TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.bold,
                   color: isDark 
                       ? Theme.of(context).colorScheme.onSurface
                       : feature['color'] as MaterialColor,
                 ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  feature['desc'] as String,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark 
                        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                        : Colors.grey[700],
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  Widget _buildSafetyCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).colorScheme.surfaceContainer : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade400, Colors.green.shade600],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.verified_user,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '安全保障',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Theme.of(context).colorScheme.onSurface : Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSafetyItem('内置白名单', '系统重要目录已预设保护，不会被误删', '🛡️'),
            _buildSafetyItem('操作确认', '重要操作前会弹出确认对话框', '⚠️'),
            _buildSafetyItem('详细日志', '所有操作都有详细记录，可随时查看', '📋'),
            _buildSafetyItem('权限控制', '仅请求必要的存储权限，保护隐私', '🔐'),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyItem(String title, String description, String emoji) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).colorScheme.surface : Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark 
              ? Theme.of(context).colorScheme.outline.withOpacity(0.3)
              : Colors.green.shade100,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark 
                  ? Theme.of(context).colorScheme.surfaceContainer
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Theme.of(context).colorScheme.onSurface : Colors.green,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark 
                        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                        : Colors.grey[700],
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

  Widget _buildTipsCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? null : LinearGradient(
          colors: [Colors.orange.shade100, Colors.yellow.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: isDark ? Theme.of(context).colorScheme.surfaceContainer : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark 
                        ? Theme.of(context).colorScheme.surfaceContainer
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    '💡',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '使用技巧',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Theme.of(context).colorScheme.onSurface : Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTipItem('定期清理', '建议每周进行一次自动清理，保持手机存储空间充足', '⏰'),
            _buildTipItem('谨慎占坑', '只对确认无用的目录使用占坑功能，避免影响应用正常运行', '⚠️'),
            _buildTipItem('备份重要文件', '清理前建议备份重要文件，虽然有白名单保护但多一份保险', '💾'),
            _buildTipItem('查看日志', '定期查看历史记录，了解清理效果和系统状态', '📊'),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String title, String description, String emoji) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark 
                ? Theme.of(context).colorScheme.surface
                : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark 
              ? Theme.of(context).colorScheme.outline.withOpacity(0.3)
              : Colors.orange.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark 
                  ? Theme.of(context).colorScheme.surfaceContainer
                  : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Theme.of(context).colorScheme.onSurface : Colors.orange,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark 
                        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                        : Colors.grey[700],
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

  Widget _buildFAQCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? null : LinearGradient(
          colors: [Colors.purple.shade100, Colors.pink.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: isDark ? Theme.of(context).colorScheme.surfaceContainer : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark 
                        ? Theme.of(context).colorScheme.surfaceContainer
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    '❓',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '常见问题',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Theme.of(context).colorScheme.onSurface : Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark 
                ? Theme.of(context).colorScheme.surface
                : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark 
              ? Theme.of(context).colorScheme.outline.withOpacity(0.3)
              : Colors.purple.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Theme.of(context).colorScheme.onSurface : Colors.purple,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: TextStyle(
              fontSize: 15,
              color: isDark 
                  ? Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                  : Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}