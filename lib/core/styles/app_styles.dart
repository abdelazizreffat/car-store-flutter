import 'package:car_store/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppStyles {
  static const borderRadiusCircular10 = BorderRadius.all(Radius.circular(10.0));
  // TODO : Check if AppStyles.roundedRectangleBorder is used anywhere else or remove it(DRY)

  static const roundedRectangleBorder = RoundedRectangleBorder(
    borderRadius: AppStyles.borderRadiusCircular10,
  );

  static const String fontFamily = 'Poppins';

  static const TextStyle textStyle28BoldWhite = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  // TODO : Customize buttonTextStyle
  static const TextStyle textStyle18SemiBoldWhite = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600, //Semi-bold
    color: AppColors.white,
  );
  static const TextStyle textStyle18SemiBoldPrimary = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600, //Semi-bold
    color: AppColors.primary,
  );
  static const TextStyle textStyle20SemiBoldBlack = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600, //Semi-bold
    color: AppColors.black,
  );
  static const TextStyle textStyle20SemiBoldPrimary = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600, //Semi-bold
    color: AppColors.primary,
  );
  static const TextStyle textStyle16SemiBoldGray = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600, //Semi-bold
    color: AppColors.grey,
  );

  static const TextStyle textStyle14RegularBlack = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400, //regular
    color: AppColors.black,
  );

  static const TextStyle textStyle14MediumBlack = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500, //Medium
    color: AppColors.black,
  );
  static const TextStyle textStyle14MediumDarkGrey = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500, //Medium
    color: AppColors.darkGrey,
  );
  static const TextStyle textStyle14RegularDarkGrey = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400, //regular
    color: AppColors.darkGrey,
  );
  static const TextStyle textStyle14MediumPrimary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500, //Medium
    color: AppColors.primary,
  );

  static const double buttonElevation = 1;
}
