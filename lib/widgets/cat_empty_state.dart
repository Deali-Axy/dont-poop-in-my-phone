import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../utils/theme.dart';

class CatEmptyState extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final String emptyType; // 'scan', 'clean', 'history', 'general'
  final bool showAnimation;

  const CatEmptyState({
    Key? key,
    required this.title,
    required this.subtitle,
    this.actionText,
    this.onActionPressed,
    this.emptyType = 'general',
    this.showAnimation = true,
  }) : super(key: key);

  @override
  State<CatEmptyState> createState() => _CatEmptyStateState();
}

class _CatEmptyStateState extends State<CatEmptyState> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _scaleController;
  late Animation<double> _floatAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _floatAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    if (widget.showAnimation) {
      _startAnimations();
    }
  }

  void _startAnimations() {
    _scaleController.forward();
    _floatController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 800),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(CatTheme.getResponsivePadding(context)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 添加顶部间距以保持居中效果
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    
                    // 猫咪插图
                    _buildCatIllustration(),

                    const SizedBox(height: 24),

                    // 标题
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          widget.title,
                          textStyle: CatTheme.catTitleStyle(context).copyWith(
                            fontSize: 22,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      isRepeatingAnimation: false,
                    ),

                    const SizedBox(height: 12),

                    // 副标题
                    Text(
                      widget.subtitle,
                      style: CatTheme.catSubtitleStyle(context),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    // 个性化消息
                    _buildPersonalizedMessage(),

                    const SizedBox(height: 24),

                    // 操作按钮
                    if (widget.actionText != null && widget.onActionPressed != null) _buildActionButton(isDark),
                    
                    // 添加底部间距以保持居中效果
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCatIllustration() {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: CatTheme.catGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: CatTheme.getCatColor('pawPink').withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                _getCatIllustration(),
                style: TextStyle(fontSize: 60),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getCatIllustration() {
    switch (widget.emptyType) {
      case 'scan':
        return '🔍🐱'; // 搜索猫
      case 'clean':
        return '🧹🐱'; // 清洁猫
      case 'history':
        return '📚🐱'; // 历史猫
      case 'success':
        return '😻'; // 成功猫
      case 'error':
        return '😿'; // 错误猫
      default:
        return '😺'; // 默认微笑猫
    }
  }

  Widget _buildPersonalizedMessage() {
    final messages = _getPersonalizedMessages();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CatTheme.getCatColor('softMint').withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: CatTheme.getCatColor('eyeGreen').withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '💭',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 8),
              Text(
                '小猫的话',
                style: CatTheme.catSubtitleStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedTextKit(
            animatedTexts: messages
                .map(
                  (message) => TypewriterAnimatedText(
                    message,
                    textStyle: CatTheme.catBodyStyle(context),
                    speed: const Duration(milliseconds: 50),
                  ),
                )
                .toList(),
            repeatForever: true,
            pause: const Duration(milliseconds: 3000),
          ),
        ],
      ),
    );
  }

  List<String> _getPersonalizedMessages() {
    switch (widget.emptyType) {
      case 'scan':
        return [
          '喵~ 让我来帮您找找手机里的垃圾文件吧！',
          '我的小爪子很灵活，能找到隐藏很深的无用文件哦~',
          '扫描完成后，您的手机会变得更快更干净！',
        ];
      case 'clean':
        return [
          '哇！您的手机已经很干净了呢~',
          '我是一只爱干净的小猫，随时为您服务！',
          '定期清理可以让手机保持最佳状态哦~',
        ];
      case 'history':
        return [
          '还没有清理记录呢，快来体验一下吧！',
          '每次清理我都会记录下来，方便您查看效果~',
          '让我们一起创造第一条清理记录吧！',
        ];
      case 'success':
        return [
          '太棒了！清理任务完成得很成功~',
          '您的手机现在一定感觉轻松多了！',
          '我很开心能帮到您，下次还找我哦~',
        ];
      case 'error':
        return [
          '哎呀，出了点小问题，但是不要担心~',
          '让我重新整理一下小爪子，再试一次吧！',
          '有时候文件太顽固，需要多试几次呢~',
        ];
      default:
        return [
          '您好！我是您的清理小助手~',
          '有什么需要帮助的吗？我随时待命！',
          '让我们一起让您的手机变得更整洁吧！',
        ];
    }
  }

  Widget _buildActionButton(bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: ElevatedButton.icon(
        onPressed: widget.onActionPressed,
        icon: Icon(
          _getActionIcon(),
          size: 20,
        ),
        label: Text(
          widget.actionText!,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? CatTheme.getCatColor('pawPink') : CatTheme.getCatColor('eyeGreen'),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 8,
          shadowColor: (isDark ? CatTheme.getCatColor('pawPink') : CatTheme.getCatColor('eyeGreen')).withOpacity(0.3),
        ),
      ),
    );
  }

  IconData _getActionIcon() {
    switch (widget.emptyType) {
      case 'scan':
        return Icons.search_rounded;
      case 'clean':
        return Icons.cleaning_services_rounded;
      case 'history':
        return Icons.history_rounded;
      default:
        return Icons.play_arrow_rounded;
    }
  }
}

// 简化版的空状态组件
class SimpleCatEmptyState extends StatelessWidget {
  final String message;
  final String emoji;
  final VoidCallback? onTap;

  const SimpleCatEmptyState({
    Key? key,
    required this.message,
    this.emoji = '😺',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(CatTheme.getResponsivePadding(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: CatTheme.catSubtitleStyle(context),
              textAlign: TextAlign.center,
            ),
            if (onTap != null) const SizedBox(height: 16),
            if (onTap != null)
              Text(
                '点击重试',
                style: CatTheme.catBodyStyle(context).copyWith(
                  color: CatTheme.getCatColor('eyeBlue'),
                  decoration: TextDecoration.underline,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
