import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/core/widgets/custom_app_logo.dart';
import 'package:flutter/material.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomAppLogo(color: AppColors.primary),
        SizedBox(height: 50),
        Text(AppStrings.signUp, style: AppStyles.textStyle20SemiBoldBlack),
        SizedBox(height: 4),
        Text(
          AppStrings.findYourDreamCar,
          style: AppStyles.textStyle14RegularBlack,
        ),
      ],
    );
  }
}
