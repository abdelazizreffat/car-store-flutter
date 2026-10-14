part of 'car_details_cubit.dart';

sealed class CarDetailsState extends Equatable {
  const CarDetailsState();

  @override
  List<Object?> get props => [];
}

final class CarDetailsInitial extends CarDetailsState {}

final class CarDetailsLoading extends CarDetailsState {}

final class CarDetailsSuccess extends CarDetailsState {
  final CarModel car;
  const CarDetailsSuccess(this.car);

  @override
  List<Object?> get props => [car];
}

final class CarDetailsError extends CarDetailsState {
  final String message;
  const CarDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}