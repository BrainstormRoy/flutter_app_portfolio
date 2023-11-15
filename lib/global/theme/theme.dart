// import 'package:flutter/material.dart';

// // Theme.of(context).colorScheme.background,

// ThemeData lightMode = ThemeData(
//   useMaterial3: true,
//   brightness: Brightness.light,
//   colorScheme: const ColorScheme.light(
//     primary: Color(0xFF6750A4),
//     onPrimary: Color(0xFFFFFFFF),
//     primaryContainer: Color(0xFFEADDFF),
//     onPrimaryContainer: Color(0xFF21005D),
//     secondary: Color(0xFF625B71),
//     onSecondary: Color(0xFFFFFFFF),
//     secondaryContainer: Color(0xFFE8DEF8),
//     onSecondaryContainer: Color(0xFF1D192B),
//     tertiary: Color(0xFF7D5260),
//     onTertiary: Color(0xFFFFFFFF),
//     tertiaryContainer: Color(0xFFFFD8E4),
//     onTertiaryContainer: Color(0xFF31111D),
//     error: Color(0xFFB3261E),
//     onError: Color(0xFFFFFFFF),
//     errorContainer: Color(0xFFF9DEDC),
//     onErrorContainer: Color(0xFF410E0B),
//     outline: Color(0xFF79747E),
//     background: Color(0xFFFFFBFE),
//     onBackground: Color(0xFF1C1B1F),
//     surface: Color(0xFFFFFBFE),
//     onSurface: Color(0xFF1C1B1F),
//     surfaceVariant: Color(0xFFE7E0EC),
//     onSurfaceVariant: Color(0xFF49454F),
//     inverseSurface: Color(0xFF313033),
//     onInverseSurface: Color(0xFFF4EFF4),
//     inversePrimary: Color(0xFFD0BCFF),
//     shadow: Color(0xFF000000),
//     surfaceTint: Color(0xFF6750A4),
//     outlineVariant: Color(0xFFCAC4D0),
//     scrim: Color(0xFF000000),
//   ),
// );

// ThemeData darkMode = ThemeData(
//   useMaterial3: true,
//   brightness: Brightness.dark,
//   colorScheme: const ColorScheme.dark(
//     primary: Color(0xFF6750A4),
//     onPrimary: Color(0xFFFFFFFF),
//     primaryContainer: Color(0xFFEADDFF),
//     onPrimaryContainer: Color(0xFF21005D),
//     secondary: Color(0xFF625B71),
//     onSecondary: Color(0xFFFFFFFF),
//     secondaryContainer: Color(0xFFE8DEF8),
//     onSecondaryContainer: Color(0xFF1D192B),
//     tertiary: Color(0xFF7D5260),
//     onTertiary: Color(0xFFFFFFFF),
//     tertiaryContainer: Color(0xFFFFD8E4),
//     onTertiaryContainer: Color(0xFF31111D),
//     error: Color(0xFFB3261E),
//     onError: Color(0xFFFFFFFF),
//     errorContainer: Color(0xFFF9DEDC),
//     onErrorContainer: Color(0xFF410E0B),
//     outline: Color(0xFF79747E),
//     background: Color(0xFFFFFBFE),
//     onBackground: Color(0xFF1C1B1F),
//     surface: Color(0xFFFFFBFE),
//     onSurface: Color(0xFF1C1B1F),
//     surfaceVariant: Color(0xFFE7E0EC),
//     onSurfaceVariant: Color(0xFF49454F),
//     inverseSurface: Color(0xFF313033),
//     onInverseSurface: Color(0xFFF4EFF4),
//     inversePrimary: Color(0xFFD0BCFF),
//     shadow: Color(0xFF000000),
//     surfaceTint: Color(0xFF6750A4),
//     outlineVariant: Color(0xFFCAC4D0),
//     scrim: Color(0xFF000000),
//   ),
// );

import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFF606C38);
Color onPrimaryColor = const Color(0xFF283618);
Color primaryContainerColor = const Color(0xFFFEFAE0);
Color onPrimaryContainerColor = const Color(0xFFDDA15E);
Color secondaryColor = const Color(0xFFBC6C25);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    primaryContainer: primaryContainerColor,
    onPrimaryContainer: onPrimaryContainerColor,
    secondary: secondaryColor,
    // Update other colors as needed...
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    primaryContainer: primaryContainerColor,
    onPrimaryContainer: onPrimaryContainerColor,
    secondary: secondaryColor,
    // Update other colors as needed...
  ),
);
