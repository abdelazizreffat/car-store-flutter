import 'package:flutter/material.dart';

abstract class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary orange colors
  static const Color primary = Color(0xFFFF5C00);
  static const Color primaryLight = Color(0x80FF5C00);

  // Default background color
  static const Color background = Color(0xFFF9FAFB);

  // Pure white color
  static const Color white = Colors.white;

  // Medium grey
  static const Color grey = Color(0xFFCCCCCC);

  // Light grey
  static const Color lightGrey = Color(0xFFF0F0F0);

  // dark grey
  static const Color darkGrey = Color(0xFF808080);

  // Red color
  static const Color red = Colors.red;

  static const Color black = Colors.black;
}
