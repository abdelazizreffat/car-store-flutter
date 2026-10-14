import 'package:bloc/bloc.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/cars/data/repositories/cars_repository.dart';
import 'package:car_store/features/home/presentation/widgets/filter_bottom_sheet.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CarsRepository _repo;

  HomeCubit({required this._repo})
      : super(HomeInitial());

  Future<void> loadHome() async {
    emit(HomeLoading());
    final results = await Future.wait([
      _repo.getFeaturedCars(),
      _repo.getCars(page: 1, limit: 10),
    ]);

    final featuredResult = results[0];
    final recommendedResult = results[1];

    String? error;
    featuredResult.fold((f) => error = f.message, (_) {});
    if (error != null) { emit(HomeError(error!)); return; }
    recommendedResult.fold((f) => error = f.message, (_) {});
    if (error != null) { emit(HomeError(error!)); return; }

    emit(HomeSuccess(
      featuredCars: featuredResult.getOrElse(() => []),
      recommendedCars: recommendedResult.getOrElse(() => []),
    ));
  }

  // Applies filter params to the recommended list while keeping featured intact.
  Future<void> loadHomeWithFilters(CarFilterParams params) async {
    final current = state;
    final featured = current is HomeSuccess ? current.featuredCars : <CarModel>[];

    emit(HomeLoading());

    final results = await Future.wait([
      _repo.getFeaturedCars(),
      _repo.getCars(
        page: 1,
        limit: 20,
        brand: params.brand,
        condition: params.condition,
        minPrice: params.minPrice,
        maxPrice: params.maxPrice,
        city: params.city,
        sort: params.sort,
      ),
    ]);

    String? error;
    results[0].fold((f) => error = f.message, (_) {});
    results[1].fold((f) => error = f.message, (_) {});

    if (error != null) { emit(HomeError(error!)); return; }

    emit(HomeSuccess(
      featuredCars: results[0].getOrElse(() => featured),
      recommendedCars: results[1].getOrElse(() => []),
    ));
  }
}