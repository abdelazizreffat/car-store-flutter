import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/core/widgets/favorite_button.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FeaturedCarCard extends StatelessWidget {
  final CarModel car;

  const FeaturedCarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.push('${AppRouter.kCarDetailsView}/${car.id}', extra: car),
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Car image — BoxFit.contain keeps full car visible, light bg fills empty space
            Positioned.fill(
              child: Container(
                color: AppColors.lightGrey,
                child: car.primaryImageUrl != null
                    ? Image.network(
                        car.primaryImageUrl!,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => const Icon(
                            Icons.directions_car,
                            size: 48,
                            color: AppColors.grey),
                      )
                    : const Icon(Icons.directions_car,
                        size: 48, color: AppColors.grey),
              ),
            ),

            // Featured ribbon
            Positioned(
              top: 0,
              left: 0,
              child: _FeaturedRibbon(),
            ),

            // Favorite button
            Positioned(
              top: 8,
              right: 8,
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) => Container(
                  decoration: const BoxDecoration(
                      color: AppColors.white, shape: BoxShape.circle),
                  child: FavoriteButton(
                    car: car,
                    isFavorite: state.isFavorite(car.id),
                    onToggle: () =>
                        context.read<FavoritesCubit>().toggleFavorite(car),
                  ),
                ),
              ),
            ),

            // Car name + price at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      car.displayName,
                      style: AppStyles.textStyle14MediumBlack
                          .copyWith(color: AppColors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (car.price != null)
                      Text('Rs. ${car.price}',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedRibbon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _RibbonClipper(),
      child: Container(
        width: 80,
        height: 80,
        color: AppColors.primary,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(top: 8, left: 6),
        child: const RotatedBox(
          quarterTurns: -1,
          child: Text(
            AppStrings.featured,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class _RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) =>
      Path()
        ..lineTo(size.width, 0)
        ..lineTo(0, size.height)
        ..close();

  @override
  bool shouldReclip(_) => false;
}