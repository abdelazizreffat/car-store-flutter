// Documentation & Diagrams:
// - Technical Notes: file://./../../../docs/core/widgets/custom_button.md
// - Flowchart Diagram: file://./../../../docs/core/widgets/custom_button.mmd

import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final TextStyle? buttonTextStyle;

  final String buttonLabel;

  final Color? foregroundColor;
  final Color? overlayColor;
  final Color? backgroundColor;

  final double? minWidth;
  final double? minHeight;

  const CustomButton({
    super.key,
    required this.buttonLabel,
    this.isLoading = false,
    this.onPressed,
    this.buttonTextStyle,
    this.foregroundColor,
    this.overlayColor,
    this.backgroundColor,
    this.minWidth,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // Disable the button while loading to prevent multiple presses
      onPressed: isLoading ? null : onPressed,

      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: foregroundColor ?? AppColors.white,
        disabledBackgroundColor: backgroundColor ?? AppColors.primaryLight,
        disabledForegroundColor: foregroundColor ?? AppColors.white,
        overlayColor: overlayColor,
        minimumSize: Size(minWidth ?? double.infinity, minHeight ?? 48),
        shape: AppStyles.roundedRectangleBorder,
        elevation: AppStyles.buttonElevation,
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      // Show a loading indicator while the operation is in progress
      return SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          color: foregroundColor ?? AppColors.white,
          strokeWidth: 2.5,
        ),
      );
    }
    // Show the button label when the button is not loading
    return Text(
      buttonLabel,
      style: buttonTextStyle ?? AppStyles.textStyle18SemiBoldWhite,
    );
  }
}
