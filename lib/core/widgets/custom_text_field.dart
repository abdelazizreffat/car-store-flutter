library;

import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final bool isObscureText;
  final TextStyle? inputTextStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final FormFieldValidator<String>? validator;
  final String? labelText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final bool hasShadow;
  final Color? prefixIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final ValueChanged<String>? onChanged;

  /// A reusable customized [TextFormField] wrapped with a [Container] for soft shadowing.
  const CustomTextField({
    super.key,
    required this.labelText,
    this.height,
    this.width,
    this.prefixIcon,
    this.isObscureText = false,
    this.inputTextStyle,
    this.keyboardType,
    this.textInputAction,
    this.fillColor,
    this.validator,
    this.controller,
    this.labelStyle,
    this.floatingLabelStyle,
    this.prefixIconColor,
    this.hasShadow = false,
    this.inputFormatters,
    this.prefixText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: _shadowDecoration(),
      child: TextFormField(
        // Automatically dismisses the keyboard when the user taps outside the input field.
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },

        obscureText: isObscureText,
        style: inputTextStyle,
        keyboardType: keyboardType,
        textInputAction: textInputAction,

        // Filters out invalid characters and sanitizes pasted text from the Clipboard.
        inputFormatters: inputFormatters,

        validator: validator,
        cursorColor: AppColors.primary,
        controller: controller,
        onChanged: onChanged,
        decoration: decoration(),
      ),
    );
  }

  InputDecoration decoration() {
    return InputDecoration(
      prefixIcon: Icon(prefixIcon),
      prefixIconColor: prefixIconColor,
      prefixText: prefixText,
      filled: true,
      fillColor: fillColor,
      labelText: labelText,
      labelStyle: labelStyle,
      floatingLabelStyle: floatingLabelStyle,

      // TODO : Add these borders to AppStyles (DRY),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: AppStyles.borderRadiusCircular10,
      ),

      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
        borderRadius: AppStyles.borderRadiusCircular10,
      ),

      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.red, width: 2),
        borderRadius: AppStyles.borderRadiusCircular10,
      ),

      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.red, width: 2),
        borderRadius: AppStyles.borderRadiusCircular10,
      ),
    );
  }

  // Applies a subtle elevation shadow only when [hasShadow] is set to true.
  BoxDecoration _shadowDecoration() {
    return BoxDecoration(
      borderRadius: AppStyles.borderRadiusCircular10,
      boxShadow: hasShadow
          ? [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.2),
                blurRadius: 1,
              ),
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 3),
                blurRadius: 8,
                spreadRadius: -1,
              ),
            ]
          : null,
    );
  }
}
