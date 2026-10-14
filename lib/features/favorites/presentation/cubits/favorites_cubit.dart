import 'package:bloc/bloc.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/cars/data/repositories/cars_repository.dart';
import 'package:car_store/features/favorites/data/favorites_local_data_source.dart';
import 'package:equatable/equatable.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesLocalDataSource _local;
  final CarsRepository _repo;

  FavoritesCubit({
    required this._local,
    required this._repo,
  })  : super(const FavoritesState());

  Future<void> loadFavorites() async {
    emit(state.copyWith(isLoading: true));
    final ids = await _local.getFavoriteIds();

    // Fetch details for each favorite car
    final cars = <CarModel>[];
    for (final id in ids) {
      final result = await _repo.getCarDetails(id);
      result.fold((_) {}, (car) => cars.add(car));
    }

    emit(state.copyWith(favoriteIds: ids, favoriteCars: cars, isLoading: false));
  }

  Future<void> toggleFavorite(CarModel car) async {
    final id = car.id;
    if (id == null) return;

    final ids = Set<String>.from(state.favoriteIds);
    List<CarModel> cars = List.from(state.favoriteCars);

    if (ids.contains(id)) {
      await _local.removeFavorite(id);
      ids.remove(id);
      cars.removeWhere((c) => c.id == id);
    } else {
      await _local.addFavorite(id);
      ids.add(id);
      if (!cars.any((c) => c.id == id)) cars.add(car);
    }

    emit(state.copyWith(favoriteIds: ids, favoriteCars: cars));
  }
}