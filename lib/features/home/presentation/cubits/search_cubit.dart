import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/cars/data/repositories/cars_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

// NOTE: The API does not expose a confirmed free-text search parameter.
// Search is implemented by passing the query as the `brand` filter parameter,
// which is the only confirmed text-based filter. Results may be incomplete
// for model-name or other attribute searches until a text-search endpoint
// is confirmed in the backend.
class SearchCubit extends Cubit<SearchState> {
  final CarsRepository _repo;
  Timer? _debounce;

  SearchCubit({required this._repo})
      : super(SearchIdle());

  void onQueryChanged(String query) {
    _debounce?.cancel();
    if (query.trim().isEmpty) {
      emit(SearchIdle());
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () => _search(query));
  }

  Future<void> _search(String query) async {
    emit(SearchLoading());
    final result = await _repo.getCars(brand: query.trim(), limit: 20);
    result.fold(
      (f) => emit(SearchError(f.message)),
      (cars) => cars.isEmpty
          ? emit(SearchEmpty(query))
          : emit(SearchSuccess(cars, query)),
    );
  }

  void clear() {
    _debounce?.cancel();
    emit(SearchIdle());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}