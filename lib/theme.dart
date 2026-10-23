import 'package:flutter/material.dart';

class AppColors {
  static const brand = Color(0xFF2F5FA8);
  static const primary = Color(0xFF4A6FC4);
  static const navy = Color(0xFF1E3F7A);
  static const accent = Color(0xFFF28C28);
  static const canvas = Color(0xFFF0F4FF);
  static const surface = Color(0xFFF8FAFF);
  static const muted = Color(0xFF6B7A99);
  static const hairline = Color(0xFFE4E8F4);
  static const success = Color(0xFF23734A);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.canvas,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: AppColors.surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.navy,
      elevation: 0,
      centerTitle: false,
    ),
  );
}
