import 'package:car_store/core/constants/app_assets.dart';
import 'package:car_store/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppLogo extends StatelessWidget {
  const CustomAppLogo({super.key, this.width, this.height, this.color});
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // Getting current screen width for responsive sizing
    // TODO: Research about MediaQuery
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return SvgPicture.asset(
      AppAssets.splashLogo,
      // change logo width dynamically (35% of screen width),
      // TODO : Impleent clamp
      width: width ?? (screenWidth * 0.3).clamp(50, 200),
      height: height,
      colorFilter: ColorFilter.mode(color ?? AppColors.white, BlendMode.srcIn),
    );
  }
}
