import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';

class AppTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: moodlePurple,
      primary: moodlePurple,
      secondary: moodleBlue,
      surface: moodleSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: moodleBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: moodleWhite,
        foregroundColor: moodleTextDark,
        elevation: 1,
        surfaceTintColor: moodleWhite,
      ),
      cardTheme: CardThemeData(
        color: moodleWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: moodleBorder),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: moodleWhite,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: moodleBlue,
        linearTrackColor: moodleGrayBg,
      ),
    );
  }
}
