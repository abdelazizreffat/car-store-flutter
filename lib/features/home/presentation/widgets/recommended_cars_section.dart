import 'package:car_store/core/constants/app_colors.dart';
import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/styles/app_styles.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/home/presentation/widgets/car_grid_card.dart';
import 'package:flutter/material.dart';

class RecommendedCarsSection extends StatelessWidget {
  final List<CarModel> cars;

  const RecommendedCarsSection({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    if (cars.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.recommended,
                  style: AppStyles.textStyle20SemiBoldBlack),
              TextButton(
                onPressed: () {},
                child: const Text(AppStrings.seeAll,
                    style: TextStyle(color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
            itemCount: cars.length,
            itemBuilder: (_, i) => CarGridCard(car: cars[i]),
          ),
        ],
      ),
    );
  }
}