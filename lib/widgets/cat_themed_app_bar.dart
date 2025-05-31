import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';

import '../utils/theme.dart';
import '../states/theme.dart';

class CatThemedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showThemeToggle;
  final VoidCallback? onBackPressed;
  final bool showBackButton;

  const CatThemedAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showThemeToggle = true,
    this.onBackPressed,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  State<CatThemedAppBar> createState() => _CatThemedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CatThemedAppBarState extends State<CatThemedAppBar>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _rotationController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    // 启动周期性动画
    _startPeriodicAnimations();
  }

  void _startPeriodicAnimations() {
    // 每5秒执行一次弹跳动画
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _bounceController.forward().then((_) {
          _bounceController.reverse().then((_) {
            Future.delayed(const Duration(seconds: 5), () {
              if (mounted) _startPeriodicAnimations();
            });
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeState>(context);
    final isDark = themeState.darkMode;

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: isDark ? null : CatTheme.catGradient,
          color: isDark ? Theme.of(context).colorScheme.surface : null,
        ),
      ),
      leading: widget.showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: widget.onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      title: Row(
        children: [
          // 猫咪图标动画
          GestureDetector(
            onTap: () {
              _rotationController.forward().then((_) {
                _rotationController.reset();
              });
            },
            child: AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _bounceAnimation.value,
                  child: RotationTransition(
                    turns: _rotationAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CatTheme.getCatColor('pawPink').withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '🐱',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          
          // 标题动画
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  key: ValueKey(widget.title),
                  animatedTexts: [
                    TypewriterAnimatedText(
                      widget.title,
                      textStyle: CatTheme.catTitleStyle(context).copyWith(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
                Text(
                  '让小猫帮您清理手机 🐾',
                  style: CatTheme.catBodyStyle(context).copyWith(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // 主题切换按钮
        if (widget.showThemeToggle)
          _buildThemeToggleButton(themeState, isDark),
        
        // 其他操作按钮
        if (widget.actions != null) ...widget.actions!,
        
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildThemeToggleButton(ThemeState themeState, bool isDark) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return RotationTransition(
          turns: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: IconButton(
        key: ValueKey(isDark),
        icon: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark
                ? CatTheme.getCatColor('eyeYellow').withOpacity(0.2)
                : CatTheme.getCatColor('eyeBlue').withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            color: isDark
                ? CatTheme.getCatColor('eyeYellow')
                : CatTheme.getCatColor('eyeBlue'),
            size: 20,
          ),
        ),
        onPressed: () {
          themeState.darkMode = !themeState.darkMode;
          
          // 触发旋转动画
          _rotationController.forward().then((_) {
            _rotationController.reset();
          });
        },
        tooltip: isDark ? '切换到浅色模式' : '切换到深色模式',
      ),
    );
  }
}

// 猫咪主题的浮动操作按钮
class CatThemedFAB extends StatefulWidget {
  final VoidCallback? onPressed;
  final String? tooltip;
  final IconData icon;
  final String? heroTag;

  const CatThemedFAB({
    Key? key,
    this.onPressed,
    this.tooltip,
    this.icon = Icons.cleaning_services_rounded,
    this.heroTag,
  }) : super(key: key);

  @override
  State<CatThemedFAB> createState() => _CatThemedFABState();
}

class _CatThemedFABState extends State<CatThemedFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // 启动脉冲动画
    _startPulseAnimation();
  }

  void _startPulseAnimation() {
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: FloatingActionButton(
            heroTag: widget.heroTag,
            onPressed: widget.onPressed,
            tooltip: widget.tooltip ?? '开始清理',
            backgroundColor: isDark
                ? CatTheme.getCatColor('pawPink')
                : CatTheme.getCatColor('eyeGreen'),
            foregroundColor: Colors.white,
            elevation: 8,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isDark ? null : CatTheme.cleanGradient,
              ),
              child: Icon(
                widget.icon,
                size: 28,
              ),
            ),
          ),
        );
      },
    );
  }
}

// 猫咪主题的底部导航栏
class CatThemedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<BottomNavigationBarItem> items;

  const CatThemedBottomNavBar({
    Key? key,
    required this.currentIndex,
    this.onTap,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? null : CatTheme.catGradient,
        color: isDark ? Theme.of(context).colorScheme.surface : null,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: items,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: CatTheme.getCatColor('catBrown'),
        unselectedItemColor: CatTheme.getCatColor('catGray'),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: CatTheme.catBodyStyle(context).copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: CatTheme.catBodyStyle(context),
      ),
    );
  }
}