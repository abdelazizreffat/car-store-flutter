import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.black),
        onPressed: () {},
      ),
      title: Text(
        AppStrings.appName,
        style: AppStyles.textStyle20SemiBoldBlack.copyWith(
          color: AppColors.primary,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
