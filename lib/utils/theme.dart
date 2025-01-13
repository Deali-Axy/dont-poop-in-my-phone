import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278207147),
      surfaceTint: Color(4278211798),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278674421),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282670235),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4289511679),
      onSecondaryContainer: Color(4279447405),
      tertiary: Color(4286251935),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4289019591),
      onTertiaryContainer: Color(4294967295),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294637823),
      onSurface: Color(4279835428),
      onSurfaceVariant: Color(4282533461),
      outline: Color(4285757063),
      outlineVariant: Color(4290954968),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217081),
      inversePrimary: Color(4289971711),
      primaryFixed: Color(4292534783),
      onPrimaryFixed: Color(4278196297),
      primaryFixedDim: Color(4289971711),
      onPrimaryFixedVariant: Color(4278206372),
      secondaryFixed: Color(4292534783),
      onSecondaryFixed: Color(4278196297),
      secondaryFixedDim: Color(4289971711),
      onSecondaryFixedVariant: Color(4281025666),
      tertiaryFixed: Color(4294629375),
      onTertiaryFixed: Color(4281532484),
      tertiaryFixedDim: Color(4293964031),
      onTertiaryFixedVariant: Color(4285989018),
      surfaceDim: Color(4292401637),
      surfaceBright: Color(4294637823),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112255),
      surfaceContainer: Color(4293717497),
      surfaceContainerHigh: Color(4293388276),
      surfaceContainerHighest: Color(4292993774),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278205340),
      surfaceTint: Color(4278211798),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278674421),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280762494),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284183219),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4285595794),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4289019591),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294637823),
      onSurface: Color(4279835428),
      onSurfaceVariant: Color(4282270289),
      outline: Color(4284112750),
      outlineVariant: Color(4285954699),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217081),
      inversePrimary: Color(4289971711),
      primaryFixed: Color(4280052476),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278211281),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284183219),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282538393),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4289480142),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4287637427),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292401637),
      surfaceBright: Color(4294637823),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112255),
      surfaceContainer: Color(4293717497),
      surfaceContainerHigh: Color(4293388276),
      surfaceContainerHighest: Color(4292993774),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278197847),
      surfaceTint: Color(4278211798),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278205340),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278197847),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4280762494),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282253393),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4285595794),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294637823),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280230705),
      outline: Color(4282270289),
      outlineVariant: Color(4282270289),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217081),
      inversePrimary: Color(4293454847),
      primaryFixed: Color(4278205340),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278200173),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4280762494),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4278856038),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4285595794),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4283301990),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292401637),
      surfaceBright: Color(4294637823),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112255),
      surfaceContainer: Color(4293717497),
      surfaceContainerHigh: Color(4293388276),
      surfaceContainerHighest: Color(4292993774),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289971711),
      surfaceTint: Color(4289971711),
      onPrimary: Color(4278201205),
      primaryContainer: Color(4278213348),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4289971711),
      onSecondary: Color(4279250282),
      secondaryContainer: Color(4280302200),
      onSecondaryContainer: Color(4290957567),
      tertiary: Color(4293964031),
      onTertiary: Color(4283695213),
      tertiaryContainer: Color(4288361662),
      onTertiaryContainer: Color(4294967295),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279309083),
      onSurface: Color(4292993774),
      onSurfaceVariant: Color(4290954968),
      outline: Color(4287402145),
      outlineVariant: Color(4282533461),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993774),
      inversePrimary: Color(4278211798),
      primaryFixed: Color(4292534783),
      onPrimaryFixed: Color(4278196297),
      primaryFixedDim: Color(4289971711),
      onPrimaryFixedVariant: Color(4278206372),
      secondaryFixed: Color(4292534783),
      onSecondaryFixed: Color(4278196297),
      secondaryFixedDim: Color(4289971711),
      onSecondaryFixedVariant: Color(4281025666),
      tertiaryFixed: Color(4294629375),
      onTertiaryFixed: Color(4281532484),
      tertiaryFixedDim: Color(4293964031),
      onTertiaryFixedVariant: Color(4285989018),
      surfaceDim: Color(4279309083),
      surfaceBright: Color(4281743682),
      surfaceContainerLowest: Color(4278914582),
      surfaceContainerLow: Color(4279835428),
      surfaceContainer: Color(4280098600),
      surfaceContainerHigh: Color(4280756787),
      surfaceContainerHighest: Color(4281480254),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4290365951),
      surfaceTint: Color(4289971711),
      onPrimary: Color(4278195006),
      primaryContainer: Color(4284386303),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290365951),
      onSecondary: Color(4278195006),
      secondaryContainer: Color(4286025682),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294031103),
      onTertiary: Color(4281008186),
      tertiaryContainer: Color(4291585261),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309083),
      onSurface: Color(4294769407),
      onSurfaceVariant: Color(4291283676),
      outline: Color(4288651956),
      outlineVariant: Color(4286546579),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993774),
      inversePrimary: Color(4278206630),
      primaryFixed: Color(4292534783),
      onPrimaryFixed: Color(4278193715),
      primaryFixedDim: Color(4289971711),
      onPrimaryFixedVariant: Color(4278202497),
      secondaryFixed: Color(4292534783),
      onSecondaryFixed: Color(4278193715),
      secondaryFixedDim: Color(4289971711),
      onSecondaryFixedVariant: Color(4279776112),
      tertiaryFixed: Color(4294629375),
      onTertiaryFixed: Color(4280483887),
      tertiaryFixedDim: Color(4293964031),
      onTertiaryFixedVariant: Color(4284285049),
      surfaceDim: Color(4279309083),
      surfaceBright: Color(4281743682),
      surfaceContainerLowest: Color(4278914582),
      surfaceContainerLow: Color(4279835428),
      surfaceContainer: Color(4280098600),
      surfaceContainerHigh: Color(4280756787),
      surfaceContainerHighest: Color(4281480254),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294769407),
      surfaceTint: Color(4289971711),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4290365951),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294769407),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290365951),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965754),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294031103),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309083),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294769407),
      outline: Color(4291283676),
      outlineVariant: Color(4291283676),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993774),
      inversePrimary: Color(4278199655),
      primaryFixed: Color(4292929279),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4290365951),
      onPrimaryFixedVariant: Color(4278195006),
      secondaryFixed: Color(4292929279),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290365951),
      onSecondaryFixedVariant: Color(4278195006),
      tertiaryFixed: Color(4294761983),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294031103),
      onTertiaryFixedVariant: Color(4281008186),
      surfaceDim: Color(4279309083),
      surfaceBright: Color(4281743682),
      surfaceContainerLowest: Color(4278914582),
      surfaceContainerLow: Color(4279835428),
      surfaceContainer: Color(4280098600),
      surfaceContainerHigh: Color(4280756787),
      surfaceContainerHighest: Color(4281480254),
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
