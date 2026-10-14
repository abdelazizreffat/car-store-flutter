import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    fontFamily: AppStyles.fontFamily,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.black,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: true,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        overlayColor: AppColors.primary.withValues(alpha: 0.1),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      overlayColor: WidgetStatePropertyAll(
        AppColors.primary.withValues(alpha: 0.1),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionHandleColor: AppColors.primary,
      selectionColor: AppColors.primary.withValues(alpha: 0.25),
    ),
  );
}
