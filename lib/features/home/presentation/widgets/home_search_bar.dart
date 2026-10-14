import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/di/service_locator.dart';
import 'package:car_store/features/cars/data/repositories/cars_repository.dart';
import 'package:car_store/features/home/presentation/cubits/search_cubit.dart';
import 'package:car_store/features/home/presentation/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSearchBar extends StatefulWidget {
  final ValueChanged<CarFilterParams?>? onFilterApplied;

  const HomeSearchBar({super.key, this.onFilterApplied});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _ctrl,
                onChanged: (q) => context.read<SearchCubit>().onQueryChanged(q),
                decoration: const InputDecoration(
                  hintText: AppStrings.searchHint,
                  hintStyle: TextStyle(fontSize: 13, color: AppColors.darkGrey),
                  prefixIcon: Icon(Icons.search, color: AppColors.darkGrey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () async {
              final result = await showFilterBottomSheet(
                context,
                repo: sl<CarsRepository>(),
              );

              widget.onFilterApplied?.call(result);
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.tune, color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
