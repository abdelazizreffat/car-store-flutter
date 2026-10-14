import 'package:car_store/core/errors/failures.dart';
import 'package:car_store/features/cars/data/data_sources/cars_remote_data_source.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/cars/data/models/filter_options_model.dart';
import 'package:car_store/features/cars/data/repositories/cars_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CarsRepositoryImpl implements CarsRepository {
  final CarsRemoteDataSource _remote;

  const CarsRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<CarModel>>> getFeaturedCars() async {
    try {
      final r = await _remote.getFeaturedCars();
      if (r.success == true) return Right(r.data?.cars ?? []);
      return const Left(UnknownFailure());
    } on DioException catch (e) {
      return Left(dioExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<CarModel>>> getCars({
    int page = 1,
    int limit = 10,
    String? brand,
    String? condition,
    String? minPrice,
    String? maxPrice,
    String? city,
    String? sort,
  }) async {
    try {
      final r = await _remote.getCars(
        page: page,
        limit: limit,
        brand: brand,
        condition: condition,
        minPrice: minPrice,
        maxPrice: maxPrice,
        city: city,
        sort: sort,
      );
      if (r.success == true) return Right(r.data?.cars ?? []);
      return const Left(UnknownFailure());
    } on DioException catch (e) {
      return Left(dioExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, CarModel>> getCarDetails(String carId) async {
    try {
      final r = await _remote.getCarDetails(carId);
      if (r.success == true && r.data != null) return Right(r.data!);
      return const Left(UnknownFailure());
    } on DioException catch (e) {
      return Left(dioExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, FilterOptionsModel>> getFilterOptions() async {
    try {
      final r = await _remote.getFilterOptions();
      return Right(r);
    } on DioException catch (e) {
      return Left(dioExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}