import 'package:flutter/material.dart';
import 'app_colors.dart';


class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground, // Background screen
  cardColor: AppColors.lightCard,                      // Form box
  dividerColor: AppColors.lightBorder,                 // Borders
  hintColor: AppColors.lightHint,
  colorScheme: const ColorScheme.light(
  primary: AppColors.lightPrimary,         // Buttons
  onPrimary: AppColors.white,              // Texts on buttons
  secondary: AppColors.lightLink,
  surface: AppColors.lightBackground,
  onSurface: AppColors.lightTextPrimary,   // Main text color
  onSurfaceVariant: AppColors.lightTextSecondary, // Secondary text
  error: AppColors.lightError,             // Error messages
  ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  cardColor: AppColors.darkCard,
  dividerColor: AppColors.darkBorder,
  hintColor: AppColors.darkHint,
  colorScheme: const ColorScheme.dark(
  primary: AppColors.darkPrimary,
  onPrimary: AppColors.white,
  secondary: AppColors.darkLink,
  surface: AppColors.darkBackground,
  onSurface: AppColors.darkTextPrimary,
  onSurfaceVariant: AppColors.darkTextSecondary,
  error: AppColors.darkError,
  ),
  );
}
