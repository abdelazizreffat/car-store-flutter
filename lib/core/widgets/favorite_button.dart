import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final CarModel car;
  final bool isFavorite;
  final VoidCallback onToggle;
  final double size;

  const FavoriteButton({
    super.key,
    required this.car,
    required this.isFavorite,
    required this.onToggle,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? AppColors.primary : AppColors.darkGrey,
        size: size,
      ),
      onPressed: onToggle,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(minWidth: size + 8, minHeight: size + 8),
    );
  }
}