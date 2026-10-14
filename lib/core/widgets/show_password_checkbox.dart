import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:flutter/material.dart';

class ShowPasswordCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ShowPasswordCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(20),
        overlayColor: WidgetStatePropertyAll(
          AppColors.primary.withValues(alpha: 0.1),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(end: 8, top: 4, bottom: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: value,
                onChanged: (newValue) {
                  onChanged(newValue ?? false);
                },
                activeColor: AppColors.primary,
                checkColor: AppColors.white,
                side: BorderSide(color: AppColors.grey, width: 2),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Text(
                AppStrings.showPassword,
                style: AppStyles.textStyle14RegularDarkGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
