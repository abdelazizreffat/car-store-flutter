import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/features/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:car_store/features/home/presentation/widgets/car_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoritesViewBody extends StatelessWidget {
  const FavoritesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          AppStrings.favorites,
          style: AppStyles.textStyle20SemiBoldPrimary,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.favoriteCars.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: AppColors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.noFavorites,
                    style: AppStyles.textStyle20SemiBoldBlack,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.noFavoritesSubtitle,
                    style: AppStyles.textStyle14RegularBlack,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.favoritesLocalOnly,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.darkGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.78,
            ),
            itemCount: state.favoriteCars.length,
            itemBuilder: (_, i) {
              final car = state.favoriteCars[i];
              return CarGridCard(
                car: car,
                onTap: () => context.push(
                  '${AppRouter.kCarDetailsView}/${car.id}',
                  extra: car,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
