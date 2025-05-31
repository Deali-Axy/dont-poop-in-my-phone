import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../utils/theme.dart';
import '../models/index.dart';
import '../services/auto_clean_service.dart';

class AnimatedStatCard extends StatefulWidget {
  final CleanStatistics? statistics;
  final bool isLoading;
  final VoidCallback? onTap;
  final int animationIndex;

  const AnimatedStatCard({
    Key? key,
    this.statistics,
    this.isLoading = false,
    this.onTap,
    this.animationIndex = 0,
  }) : super(key: key);

  @override
  State<AnimatedStatCard> createState() => _AnimatedStatCardState();
}

class _AnimatedStatCardState extends State<AnimatedStatCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _progressController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOutCubic,
    ));

    // 启动动画
    Future.delayed(Duration(milliseconds: widget.animationIndex * 100), () {
      if (mounted) {
        _scaleController.forward();
        _progressController.forward();
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statistics = widget.statistics;

    return AnimationConfiguration.staggeredList(
      position: widget.animationIndex,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                width: CatTheme.getResponsiveCardWidth(context),
                margin: EdgeInsets.symmetric(
                  horizontal: CatTheme.getResponsivePadding(context),
                  vertical: 8,
                ),
                decoration: CatTheme.catCardDecoration(context, isDark: isDark),
                child: Padding(
                  padding: EdgeInsets.all(CatTheme.getResponsivePadding(context)),
                  child: widget.isLoading
                      ? _buildLoadingContent()
                      : _buildStatisticsContent(statistics, isDark),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '🙀',
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '正在扫描中...',
                    style: CatTheme.catTitleStyle(context),
                  ),
                  const SizedBox(height: 8),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '小猫正在努力清理您的手机 🐾',
                        textStyle: CatTheme.catSubtitleStyle(context),
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        '请稍等片刻，马上就好了 😸',
                        textStyle: CatTheme.catSubtitleStyle(context),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    repeatForever: true,
                    pause: const Duration(milliseconds: 1000),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        LinearPercentIndicator(
          lineHeight: 8.0,
          percent: 1.0,
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          progressColor: CatTheme.getCatColor('pawPink'),
          animation: true,
          animationDuration: 2000,
          barRadius: const Radius.circular(4),
        ),
      ],
    );
  }

  Widget _buildStatisticsContent(CleanStatistics? statistics, bool isDark) {
    if (statistics == null) {
      return _buildEmptyState();
    }

    final totalFiles = statistics.totalTasks;
    final cleanedFiles = statistics.cleanedFiles;
    final savedSpace = statistics.savedSpace;
    final progress = totalFiles > 0 ? cleanedFiles / totalFiles : 0.0;

    return Column(
      children: [
        // 标题行
        Row(
          children: [
            Text(
              CatTheme.getCatEmoji('success'),
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '清理统计',
                    style: CatTheme.catTitleStyle(context),
                  ),
                  Text(
                    '让您的手机更加整洁',
                    style: CatTheme.catSubtitleStyle(context),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // 进度圆环
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 8.0,
              percent: progress * _progressAnimation.value,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      '${(progress * _progressAnimation.value * 100).toInt()}%',
                      key: ValueKey(progress * _progressAnimation.value),
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CatTheme.getCatColor('catBrown'),
                      ),
                    ),
                  ),
                  Text(
                    '完成度',
                    style: CatTheme.catBodyStyle(context),
                  ),
                ],
              ),
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              progressColor: CatTheme.getCatColor('eyeGreen'),
              circularStrokeCap: CircularStrokeCap.round,
              animation: false, // 我们使用自定义动画
            );
          },
        ),
        
        const SizedBox(height: 24),
        
        // 统计数据行
        Row(
          children: [
            Expanded(
              child: _buildStatItem(
                icon: '📁',
                label: '总文件',
                value: totalFiles.toString(),
                color: CatTheme.getCatColor('catBlue'),
              ),
            ),
            Expanded(
              child: _buildStatItem(
                icon: '🗑️',
                label: '已清理',
                value: cleanedFiles.toString(),
                color: CatTheme.getCatColor('eyeGreen'),
              ),
            ),
            Expanded(
              child: _buildStatItem(
                icon: '💾',
                label: '节省空间',
                value: _formatFileSize(savedSpace),
                color: CatTheme.getCatColor('pawPink'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              CatTheme.getCatEmoji('clean'),
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '暂无数据',
                    style: CatTheme.catTitleStyle(context),
                  ),
                  Text(
                    '点击开始扫描您的设备',
                    style: CatTheme.catSubtitleStyle(context),
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
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: CatTheme.getCatColor('catGray'),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '小猫还没有开始工作哦，快来让它帮您清理手机吧！',
                  style: CatTheme.catBodyStyle(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * _progressAnimation.value),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  icon,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 8),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  value,
                  key: ValueKey(value),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Text(
                label,
                style: CatTheme.catBodyStyle(context).copyWith(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }
}

// 动画数字计数器组件
class AnimatedCounter extends StatefulWidget {
  final int value;
  final Duration duration;
  final TextStyle? textStyle;

  const AnimatedCounter({
    Key? key,
    required this.value,
    this.duration = const Duration(milliseconds: 1000),
    this.textStyle,
  }) : super(key: key);

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.value.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      _animation = Tween<double>(
        begin: _previousValue.toDouble(),
        end: widget.value.toDouble(),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ));
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          _animation.value.toInt().toString(),
          style: widget.textStyle,
        );
      },
    );
  }
}