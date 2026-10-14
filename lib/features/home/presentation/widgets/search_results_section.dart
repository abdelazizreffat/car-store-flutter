import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/routing/app_router.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/features/home/presentation/cubits/search_cubit.dart';
import 'package:car_store/features/home/presentation/widgets/car_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchResultsSection extends StatelessWidget {
  const SearchResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchIdle) return const SizedBox.shrink();

        if (state is SearchLoading) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child:
                Center(child: CircularProgressIndicator(color: AppColors.primary)),
          );
        }

        if (state is SearchError) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(child: Text(state.message)),
          );
        }

        if (state is SearchEmpty) {
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const Icon(Icons.search_off, size: 48, color: AppColors.grey),
                const SizedBox(height: 12),
                Text(AppStrings.noResults,
                    style: AppStyles.textStyle20SemiBoldBlack),
                Text(AppStrings.noResultsSubtitle,
                    style: AppStyles.textStyle14RegularBlack,
                    textAlign: TextAlign.center),
              ],
            ),
          );
        }

        if (state is SearchSuccess) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${AppStrings.searchResults} (${state.results.length})',
                    style: AppStyles.textStyle20SemiBoldBlack),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: state.results.length,
                  itemBuilder: (_, i) {
                    final car = state.results[i];
                    return CarGridCard(
                      car: car,
                      onTap: () => context.push(
                          '${AppRouter.kCarDetailsView}/${car.id}',
                          extra: car),
                    );
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}