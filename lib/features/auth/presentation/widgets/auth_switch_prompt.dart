import 'package:car_store/core/styles/app_styles.dart';
import 'package:flutter/material.dart';

class AuthSwitchPrompt extends StatelessWidget {
  final VoidCallback? onPressed;

  final String text;

  final String actionText;

  const AuthSwitchPrompt({
    super.key,
    required this.text,
    required this.actionText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text, style: AppStyles.textStyle14MediumDarkGrey),
        TextButton(
          onPressed: onPressed,
          child: Text(actionText, style: AppStyles.textStyle14MediumPrimary),
        ),
      ],
    );
  }
}
