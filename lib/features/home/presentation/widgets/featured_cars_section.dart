import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/home/presentation/widgets/featured_car_card.dart';
import 'package:flutter/material.dart';

class FeaturedCarsSection extends StatelessWidget {
  final List<CarModel> cars;

  const FeaturedCarsSection({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    if (cars.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: cars.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) => FeaturedCarCard(car: cars[i]),
      ),
    );
  }
}