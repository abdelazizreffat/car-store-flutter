import 'package:bloc/bloc.dart';
import 'package:car_store/features/cars/data/models/car_model.dart';
import 'package:car_store/features/cars/data/repositories/cars_repository.dart';
import 'package:equatable/equatable.dart';

part 'car_details_state.dart';

class CarDetailsCubit extends Cubit<CarDetailsState> {
  final CarsRepository _repo;

  CarDetailsCubit({required this._repo})
      : super(CarDetailsInitial());

  // If a prefetched car is provided (from the list), show it immediately
  // and then refresh with the full details from the API.
  Future<void> loadDetails(String carId, {CarModel? prefetched}) async {
    if (prefetched != null) {
      emit(CarDetailsSuccess(prefetched));
    } else {
      emit(CarDetailsLoading());
    }

    final result = await _repo.getCarDetails(carId);
    result.fold(
      (f) {
        if (prefetched == null) emit(CarDetailsError(f.message));
        // If we already have prefetched data, keep showing it on error
      },
      (car) => emit(CarDetailsSuccess(car)),
    );
  }
}