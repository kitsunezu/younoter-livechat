import 'package:flutter/material.dart';

final ColorScheme _younoterLightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF404249),
  brightness: Brightness.light,
).copyWith(
  primary: const Color(0xFF2B2D31),
  onPrimary: Colors.white,
  primaryContainer: const Color(0xFFD7D9DE),
  onPrimaryContainer: const Color(0xFF16171A),
  secondary: const Color(0xFF4E5058),
  onSecondary: Colors.white,
  secondaryContainer: const Color(0xFFE6E8EB),
  onSecondaryContainer: const Color(0xFF1C1D21),
  tertiary: const Color(0xFF6B7280),
  onTertiary: Colors.white,
  tertiaryContainer: const Color(0xFFE5E7EB),
  onTertiaryContainer: const Color(0xFF111827),
  surface: const Color(0xFFF7F8FA),
  onSurface: const Color(0xFF1E1F22),
  onSurfaceVariant: const Color(0xFF5C5F67),
  outline: const Color(0xFFC7CAD1),
  outlineVariant: const Color(0xFFDDE0E5),
  surfaceTint: const Color(0xFF2B2D31),
);

final ColorScheme _younoterDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF313338),
  brightness: Brightness.dark,
).copyWith(
  primary: const Color(0xFFE3E5E8),
  onPrimary: const Color(0xFF1E1F22),
  primaryContainer: const Color(0xFF3A3D44),
  onPrimaryContainer: const Color(0xFFF2F3F5),
  secondary: const Color(0xFFC9CDD3),
  onSecondary: const Color(0xFF1E1F22),
  secondaryContainer: const Color(0xFF313338),
  onSecondaryContainer: const Color(0xFFE3E5E8),
  tertiary: const Color(0xFFAAB0BB),
  onTertiary: const Color(0xFF1A1B1F),
  tertiaryContainer: const Color(0xFF3B3F46),
  onTertiaryContainer: const Color(0xFFE8EAED),
  surface: const Color(0xFF1E1F22),
  onSurface: const Color(0xFFE3E5E8),
  onSurfaceVariant: const Color(0xFFA8ADB7),
  outline: const Color(0xFF555A63),
  outlineVariant: const Color(0xFF3B3F46),
  surfaceTint: const Color(0xFFE3E5E8),
);

/// YouNoter light theme.
final ThemeData younoterLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: _younoterLightColorScheme,
  fontFamily: 'Segoe UI',
  scaffoldBackgroundColor: const Color(0xFFF2F3F5),
  canvasColor: const Color(0xFFF2F3F5),
  cardTheme: const CardThemeData(
    elevation: 1,
    color: Color(0xFFFFFFFF),
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFFDDE0E5),
    thickness: 1,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color(0xFFFFFFFF),
    indicatorColor: Color(0xFFE6E8EB),
  ),
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: Color(0xFFF7F8FA),
    indicatorColor: Color(0xFFE6E8EB),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFFFFFFF),
    border: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _younoterLightColorScheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _younoterLightColorScheme.primary),
    ),
    isDense: true,
  ),
);

/// YouNoter dark theme.
final ThemeData younoterDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: _younoterDarkColorScheme,
  fontFamily: 'Segoe UI',
  scaffoldBackgroundColor: const Color(0xFF1E1F22),
  canvasColor: const Color(0xFF1E1F22),
  cardTheme: const CardThemeData(
    elevation: 1,
    color: Color(0xFF2B2D31),
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFF3B3F46),
    thickness: 1,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color(0xFF2B2D31),
    indicatorColor: Color(0xFF3A3D44),
  ),
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: Color(0xFF1E1F22),
    indicatorColor: Color(0xFF3A3D44),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2B2D31),
    border: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _younoterDarkColorScheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _younoterDarkColorScheme.primary),
    ),
    isDense: true,
  ),
);
