import 'package:car_store/core/errors/failures.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/cars/data/models/filter_options_model.dart';
import 'package:dartz/dartz.dart';

abstract class CarsRepository {
  Future<Either<Failure, List<CarModel>>> getFeaturedCars();

  Future<Either<Failure, List<CarModel>>> getCars({
    int page,
    int limit,
    String? brand,
    String? condition,
    String? minPrice,
    String? maxPrice,
    String? city,
    String? sort,
  });

  Future<Either<Failure, CarModel>> getCarDetails(String carId);

  Future<Either<Failure, FilterOptionsModel>> getFilterOptions();
}