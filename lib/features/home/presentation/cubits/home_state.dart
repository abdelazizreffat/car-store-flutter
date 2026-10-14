part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<CarModel> featuredCars;
  final List<CarModel> recommendedCars;

  const HomeSuccess({
    required this.featuredCars,
    required this.recommendedCars,
  });

  @override
  List<Object?> get props => [featuredCars, recommendedCars];
}

final class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}