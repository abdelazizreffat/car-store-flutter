import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/features/home/presentation/cubits/home_cubit.dart';
import 'package:car_store/features/home/presentation/cubits/search_cubit.dart';
import 'package:car_store/features/home/presentation/widgets/featured_cars_section.dart';
import 'package:car_store/features/home/presentation/widgets/filter_bottom_sheet.dart';
import 'package:car_store/features/home/presentation/widgets/home_app_bar.dart';
import 'package:car_store/features/home/presentation/widgets/home_search_bar.dart';
import 'package:car_store/features/home/presentation/widgets/recommended_cars_section.dart';
import 'package:car_store/features/home/presentation/widgets/search_results_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  void _applyFilters(CarFilterParams? params) {
    if (params == null) return;
    context.read<HomeCubit>().loadHomeWithFilters(params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const HomeAppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.read<HomeCubit>().loadHome(),
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          }

          if (state is HomeSuccess) {
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () => context.read<HomeCubit>().loadHome(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: HomeSearchBar(onFilterApplied: _applyFilters),
                  ),
                  // Show search results when searching, otherwise show home content
                  const SliverToBoxAdapter(child: SearchResultsSection()),
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, searchState) {
                      if (searchState is! SearchIdle) {
                        return const SliverToBoxAdapter(
                          child: SizedBox.shrink(),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          FeaturedCarsSection(cars: state.featuredCars),
                          RecommendedCarsSection(cars: state.recommendedCars),
                          const SizedBox(height: 24),
                        ]),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
