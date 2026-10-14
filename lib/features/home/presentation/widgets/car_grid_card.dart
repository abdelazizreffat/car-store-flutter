import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/core/widgets/favorite_button.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CarGridCard extends StatelessWidget {
  final CarModel car;
  final VoidCallback? onTap;

  const CarGridCard({super.key, required this.car, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () => context.push(
            '${AppRouter.kCarDetailsView}/${car.id}',
            extra: car,
          ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  // Image — BoxFit.contain so the full car body is always visible
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Container(
                      color: AppColors.lightGrey,
                      width: double.infinity,
                      height: double.infinity,
                      child: car.primaryImageUrl != null
                          ? Image.network(
                              car.primaryImageUrl!,
                              fit: BoxFit.contain,
                              errorBuilder: (_, _, _) => const Icon(
                                Icons.directions_car,
                                size: 36,
                                color: AppColors.grey,
                              ),
                            )
                          : const Icon(
                              Icons.directions_car,
                              size: 36,
                              color: AppColors.grey,
                            ),
                    ),
                  ),
                  // 360 View badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.threesixty,
                            color: AppColors.white,
                            size: 12,
                          ),
                          SizedBox(width: 3),
                          Text(
                            '360 View',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 4,
                    right: 4,
                    child: BlocBuilder<FavoritesCubit, FavoritesState>(
                      builder: (context, state) => Container(
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: FavoriteButton(
                          car: car,
                          isFavorite: state.isFavorite(car.id),
                          onToggle: () => context
                              .read<FavoritesCubit>()
                              .toggleFavorite(car),
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.displayName,
                    style: AppStyles.textStyle14MediumBlack,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rs. ${car.price ?? ''}',
                    style: AppStyles.textStyle14MediumDarkGrey,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
