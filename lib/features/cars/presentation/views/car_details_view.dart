import 'package:car_store/core/di/service_locator.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/cars/presentation/cubits/car_details_cubit.dart';
import 'package:car_store/features/cars/presentation/widgets/car_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailsView extends StatelessWidget {
  final String carId;
  final CarModel? prefetched;

  const CarDetailsView({super.key, required this.carId, this.prefetched});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarDetailsCubit>(
      create: (_) =>
          sl<CarDetailsCubit>()..loadDetails(carId, prefetched: prefetched),
      child: const CarDetailsViewBody(),
    );
  }
}