import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF00A693), // 基于RGB(134, 229, 206)的深色变体作为主色
      surfaceTint: Color(0xFF00A693),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF86E5CE), // RGB(134, 229, 206) - 图标颜色
      onPrimaryContainer: Color(0xFF003D36),
      secondary: Color(0xFF4A9B8E), // 互补的青绿色
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFB8F0E3), // 浅薄荷绿
      onSecondaryContainer: Color(0xFF002B24),
      tertiary: Color(0xFF5A6B7D), // 中性蓝灰色作为点缀
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFE1ECF4),
      onTertiaryContainer: Color(0xFF172026),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      surface: Color(0xFFF5FFFE), // 非常浅的薄荷色背景
      onSurface: Color(0xFF161D1C),
      onSurfaceVariant: Color(0xFF3F4947),
      outline: Color(0xFF6F7977),
      outlineVariant: Color(0xFFBEC9C6),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF2B3231),
      inversePrimary: Color(0xFF86E5CE),
      primaryFixed: Color(0xFFA8F2DF),
      onPrimaryFixed: Color(0xFF002B24),
      primaryFixedDim: Color(0xFF86E5CE),
      onPrimaryFixedVariant: Color(0xFF00796B),
      secondaryFixed: Color(0xFFB8F0E3),
      onSecondaryFixed: Color(0xFF002B24),
      secondaryFixedDim: Color(0xFF9DD3C7),
      onSecondaryFixedVariant: Color(0xFF2E7A6D),
      tertiaryFixed: Color(0xFFE1ECF4),
      onTertiaryFixed: Color(0xFF172026),
      tertiaryFixedDim: Color(0xFFC5D0D8),
      onTertiaryFixedVariant: Color(0xFF425364),
      surfaceDim: Color(0xFFD5DBDA),
      surfaceBright: Color(0xFFF5FFFE),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFEFF5F4),
      surfaceContainer: Color(0xFFE9EFEE),
      surfaceContainerHigh: Color(0xFFE3E9E8),
      surfaceContainerHighest: Color(0xFFDDE4E2),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF00796B), // 更深的青绿色
      surfaceTint: Color(0xFF00796B),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF00A693),
      onPrimaryContainer: Color(0xFFFFFFFF),
      secondary: Color(0xFF2E7A6D), // 深青绿色
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFF4A9B8E),
      onSecondaryContainer: Color(0xFFFFFFFF),
      tertiary: Color(0xFF425364), // 深蓝灰色
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF5A6B7D),
      onTertiaryContainer: Color(0xFFFFFFFF),
      error: Color(0xFF8C0009),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFDA342E),
      onErrorContainer: Color(0xFFFFFFFF),
      surface: Color(0xFFF5FFFE),
      onSurface: Color(0xFF161D1C),
      onSurfaceVariant: Color(0xFF3B4543),
      outline: Color(0xFF5B6562),
      outlineVariant: Color(0xFF77817E),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF2B3231),
      inversePrimary: Color(0xFF86E5CE),
      primaryFixed: Color(0xFF00C4A7),
      onPrimaryFixed: Color(0xFFFFFFFF),
      primaryFixedDim: Color(0xFF00A693),
      onPrimaryFixedVariant: Color(0xFFFFFFFF),
      secondaryFixed: Color(0xFF6BB7AA),
      onSecondaryFixed: Color(0xFFFFFFFF),
      secondaryFixedDim: Color(0xFF4A9B8E),
      onSecondaryFixedVariant: Color(0xFFFFFFFF),
      tertiaryFixed: Color(0xFF7687A1),
      onTertiaryFixed: Color(0xFFFFFFFF),
      tertiaryFixedDim: Color(0xFF5A6B7D),
      onTertiaryFixedVariant: Color(0xFFFFFFFF),
      surfaceDim: Color(0xFFD5DBDA),
      surfaceBright: Color(0xFFF5FFFE),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFEFF5F4),
      surfaceContainer: Color(0xFFE9EFEE),
      surfaceContainerHigh: Color(0xFFE3E9E8),
      surfaceContainerHighest: Color(0xFFDDE4E2),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF003D36), // 最深的青绿色
      surfaceTint: Color(0xFF003D36),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF00796B),
      onPrimaryContainer: Color(0xFFFFFFFF),
      secondary: Color(0xFF002B24), // 最深的薄荷绿
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFF2E7A6D),
      onSecondaryContainer: Color(0xFFFFFFFF),
      tertiary: Color(0xFF172026), // 最深的蓝灰色
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF425364),
      onTertiaryContainer: Color(0xFFFFFFFF),
      error: Color(0xFF4E0002),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFF8C0009),
      onErrorContainer: Color(0xFFFFFFFF),
      surface: Color(0xFFF5FFFE),
      onSurface: Color(0xFF000000),
      onSurfaceVariant: Color(0xFF1F2624),
      outline: Color(0xFF3B4543),
      outlineVariant: Color(0xFF3B4543),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF2B3231),
      inversePrimary: Color(0xFFCCF8EC),
      primaryFixed: Color(0xFF00796B),
      onPrimaryFixed: Color(0xFFFFFFFF),
      primaryFixedDim: Color(0xFF003D36),
      onPrimaryFixedVariant: Color(0xFFFFFFFF),
      secondaryFixed: Color(0xFF2E7A6D),
      onSecondaryFixed: Color(0xFFFFFFFF),
      secondaryFixedDim: Color(0xFF002B24),
      onSecondaryFixedVariant: Color(0xFFFFFFFF),
      tertiaryFixed: Color(0xFF425364),
      onTertiaryFixed: Color(0xFFFFFFFF),
      tertiaryFixedDim: Color(0xFF172026),
      onTertiaryFixedVariant: Color(0xFFFFFFFF),
      surfaceDim: Color(0xFFD5DBDA),
      surfaceBright: Color(0xFFF5FFFE),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFEFF5F4),
      surfaceContainer: Color(0xFFE9EFEE),
      surfaceContainerHigh: Color(0xFFE3E9E8),
      surfaceContainerHighest: Color(0xFFDDE4E2),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF86E5CE), // 图标颜色作为暗色主题的主色
      surfaceTint: Color(0xFF86E5CE),
      onPrimary: Color(0xFF003D36),
      primaryContainer: Color(0xFF00796B), // 深一些的青绿色
      onPrimaryContainer: Color(0xFFA8F2DF),
      secondary: Color(0xFF9DD3C7), // 柔和的薄荷绿
      onSecondary: Color(0xFF002B24),
      secondaryContainer: Color(0xFF2E7A6D),
      onSecondaryContainer: Color(0xFFB8F0E3),
      tertiary: Color(0xFFC5D0D8), // 浅蓝灰色
      onTertiary: Color(0xFF172026),
      tertiaryContainer: Color(0xFF425364),
      onTertiaryContainer: Color(0xFFE1ECF4),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),
      surface: Color(0xFF0E1514), // 深色薄荷背景
      onSurface: Color(0xFFDDE4E2),
      onSurfaceVariant: Color(0xFFBEC9C6),
      outline: Color(0xFF889391),
      outlineVariant: Color(0xFF3F4947),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFDDE4E2),
      inversePrimary: Color(0xFF00A693),
      primaryFixed: Color(0xFFA8F2DF),
      onPrimaryFixed: Color(0xFF002B24),
      primaryFixedDim: Color(0xFF86E5CE),
      onPrimaryFixedVariant: Color(0xFF00796B),
      secondaryFixed: Color(0xFFB8F0E3),
      onSecondaryFixed: Color(0xFF002B24),
      secondaryFixedDim: Color(0xFF9DD3C7),
      onSecondaryFixedVariant: Color(0xFF2E7A6D),
      tertiaryFixed: Color(0xFFE1ECF4),
      onTertiaryFixed: Color(0xFF172026),
      tertiaryFixedDim: Color(0xFFC5D0D8),
      onTertiaryFixedVariant: Color(0xFF425364),
      surfaceDim: Color(0xFF0E1514),
      surfaceBright: Color(0xFF343B3A),
      surfaceContainerLowest: Color(0xFF090F0F),
      surfaceContainerLow: Color(0xFF161D1C),
      surfaceContainer: Color(0xFF1A2120),
      surfaceContainerHigh: Color(0xFF252B2A),
      surfaceContainerHighest: Color(0xFF2F3635),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF8AE9D0), // 更亮的薄荷绿
      surfaceTint: Color(0xFF86E5CE),
      onPrimary: Color(0xFF001F1A),
      primaryContainer: Color(0xFF4EAEA0),
      onPrimaryContainer: Color(0xFF000000),
      secondary: Color(0xFFA1D7CA), // 更亮的青绿色
      onSecondary: Color(0xFF001F1A),
      secondaryContainer: Color(0xFF679C90),
      onSecondaryContainer: Color(0xFF000000),
      tertiary: Color(0xFFC9D4DC), // 更亮的蓝灰色
      onTertiary: Color(0xFF0C1419),
      tertiaryContainer: Color(0xFF8F9AA2),
      onTertiaryContainer: Color(0xFF000000),
      error: Color(0xFFFFBAB1),
      onError: Color(0xFF370001),
      errorContainer: Color(0xFFFF5449),
      onErrorContainer: Color(0xFF000000),
      surface: Color(0xFF0E1514),
      onSurface: Color(0xFFF0F1F0),
      onSurfaceVariant: Color(0xFFC2CDCA),
      outline: Color(0xFF9CA5A2),
      outlineVariant: Color(0xFF7C8582),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFDDE4E2),
      inversePrimary: Color(0xFF006B5D),
      primaryFixed: Color(0xFFA8F2DF),
      onPrimaryFixed: Color(0xFF001912),
      primaryFixedDim: Color(0xFF86E5CE),
      onPrimaryFixedVariant: Color(0xFF005A4E),
      secondaryFixed: Color(0xFFB8F0E3),
      onSecondaryFixed: Color(0xFF001912),
      secondaryFixedDim: Color(0xFF9DD3C7),
      onSecondaryFixedVariant: Color(0xFF1A5F54),
      tertiaryFixed: Color(0xFFE1ECF4),
      onTertiaryFixed: Color(0xFF0A0F13),
      tertiaryFixedDim: Color(0xFFC5D0D8),
      onTertiaryFixedVariant: Color(0xFF2A3A42),
      surfaceDim: Color(0xFF0E1514),
      surfaceBright: Color(0xFF343B3A),
      surfaceContainerLowest: Color(0xFF090F0F),
      surfaceContainerLow: Color(0xFF161D1C),
      surfaceContainer: Color(0xFF1A2120),
      surfaceContainerHigh: Color(0xFF252B2A),
      surfaceContainerHighest: Color(0xFF2F3635),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFECFFFB), // 最亮的薄荷色
      surfaceTint: Color(0xFF86E5CE),
      onPrimary: Color(0xFF000000),
      primaryContainer: Color(0xFF8AE9D0),
      onPrimaryContainer: Color(0xFF000000),
      secondary: Color(0xFFECFFFB), // 最亮的薄荷色
      onSecondary: Color(0xFF000000),
      secondaryContainer: Color(0xFFA1D7CA),
      onSecondaryContainer: Color(0xFF000000),
      tertiary: Color(0xFFF8FAFC), // 最亮的蓝灰色
      onTertiary: Color(0xFF000000),
      tertiaryContainer: Color(0xFFC9D4DC),
      onTertiaryContainer: Color(0xFF000000),
      error: Color(0xFFFFF9F9),
      onError: Color(0xFF000000),
      errorContainer: Color(0xFFFFBAB1),
      onErrorContainer: Color(0xFF000000),
      surface: Color(0xFF0E1514),
      onSurface: Color(0xFFFFFFFF),
      onSurfaceVariant: Color(0xFFF2F8F5),
      outline: Color(0xFFC2CDCA),
      outlineVariant: Color(0xFFC2CDCA),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFDDE4E2),
      inversePrimary: Color(0xFF004A40),
      primaryFixed: Color(0xFFB2F5E2),
      onPrimaryFixed: Color(0xFF000000),
      primaryFixedDim: Color(0xFF8AE9D0),
      onPrimaryFixedVariant: Color(0xFF001F1A),
      secondaryFixed: Color(0xFFC2F4E7),
      onSecondaryFixed: Color(0xFF000000),
      secondaryFixedDim: Color(0xFFA1D7CA),
      onSecondaryFixedVariant: Color(0xFF001F1A),
      tertiaryFixed: Color(0xFFE5F0F8),
      onTertiaryFixed: Color(0xFF000000),
      tertiaryFixedDim: Color(0xFFC9D4DC),
      onTertiaryFixedVariant: Color(0xFF0C1419),
      surfaceDim: Color(0xFF0E1514),
      surfaceBright: Color(0xFF343B3A),
      surfaceContainerLowest: Color(0xFF090F0F),
      surfaceContainerLow: Color(0xFF161D1C),
      surfaceContainer: Color(0xFF1A2120),
      surfaceContainerHigh: Color(0xFF252B2A),
      surfaceContainerHighest: Color(0xFF2F3635),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

// 猫咪主题扩展
class CatTheme {
  // 猫咪主题颜色调色板
  static const Map<String, Color> catColors = {
    // 主要猫咪颜色
    'catOrange': Color(0xFFFF8A65),      // 橘猫橙色
    'catGray': Color(0xFF90A4AE),        // 灰猫灰色
    'catBlack': Color(0xFF424242),       // 黑猫黑色
    'catWhite': Color(0xFFFAFAFA),       // 白猫白色
    'catBrown': Color(0xFF8D6E63),       // 棕猫棕色
    
    // 猫咪特征颜色
    'pawPink': Color(0xFFFFAB91),        // 粉色肉垫
    'noseBlack': Color(0xFF263238),      // 黑色鼻子
    'eyeGreen': Color(0xFF66BB6A),       // 绿色眼睛
    'eyeBlue': Color(0xFF42A5F5),        // 蓝色眼睛
    'eyeYellow': Color(0xFFFFEE58),      // 黄色眼睛
    
    // 柔和背景色
    'softCream': Color(0xFFFFF8E1),      // 奶油色
    'softPeach': Color(0xFFFFE0B2),      // 桃色
    'softMint': Color(0xFFE8F5E8),       // 薄荷色
    'softLavender': Color(0xFFF3E5F5),   // 薰衣草色
    'softSky': Color(0xFFE1F5FE),        // 天空色
  };
  
  // 获取猫咪主题颜色
  static Color getCatColor(String colorName) {
    return catColors[colorName] ?? catColors['catOrange']!;
  }
  
  // 猫咪主题渐变
  static const LinearGradient catGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFE0B2), // 柔和桃色
      Color(0xFFFFAB91), // 粉色肉垫
    ],
  );
  
  // 清洁主题渐变
  static const LinearGradient cleanGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE8F5E8), // 薄荷绿
      Color(0xFF86E5CE), // 主题绿
    ],
  );
  
  // 猫咪主题文字样式
  static TextStyle catTitleStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontWeight: FontWeight.bold,
      color: isDark ? Theme.of(context).colorScheme.onSurface : getCatColor('catBrown'),
      letterSpacing: 0.5,
    );
  }
  
  static TextStyle catSubtitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      color: getCatColor('catGray'),
      fontWeight: FontWeight.w500,
    );
  }
  
  static TextStyle catBodyStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
    );
  }
  
  // 猫咪主题装饰
  static BoxDecoration catCardDecoration(BuildContext context, {bool isDark = false}) {
    return BoxDecoration(
      gradient: isDark ? null : catGradient,
      color: isDark ? Theme.of(context).colorScheme.surfaceContainer : null,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
  
  // 清洁状态颜色
  static Color getCleanStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return const Color(0xFF4CAF50); // 绿色
      case 'running':
      case 'scanning':
        return const Color(0xFF2196F3); // 蓝色
      case 'failed':
      case 'error':
        return const Color(0xFFF44336); // 红色
      case 'pending':
      case 'waiting':
        return const Color(0xFFFF9800); // 橙色
      case 'skipped':
        return const Color(0xFF9E9E9E); // 灰色
      default:
        return const Color(0xFF607D8B); // 默认蓝灰色
    }
  }
  
  // 猫咪表情图标映射
  static String getCatEmoji(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return '😸'; // 开心猫
      case 'running':
      case 'scanning':
        return '🙀'; // 忙碌猫
      case 'failed':
      case 'error':
        return '😿'; // 哭泣猫
      case 'pending':
      case 'waiting':
        return '😺'; // 微笑猫
      case 'empty':
      case 'clean':
        return '😻'; // 爱心眼猫
      default:
        return '🐱'; // 默认猫脸
    }
  }
  
  // 响应式间距
  static double getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return 16.0; // 手机
    } else if (screenWidth < 1200) {
      return 24.0; // 平板
    } else {
      return 32.0; // 桌面
    }
  }
  
  static double getResponsiveCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return screenWidth - 32; // 手机：留边距
    } else if (screenWidth < 1200) {
      return screenWidth * 0.8; // 平板：80%宽度
    } else {
      return 800; // 桌面：固定最大宽度
    }
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
