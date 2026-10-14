part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  final Set<String> favoriteIds;
  final List<CarModel> favoriteCars;
  final bool isLoading;

  const FavoritesState({
    this.favoriteIds = const {},
    this.favoriteCars = const [],
    this.isLoading = false,
  });

  FavoritesState copyWith({
    Set<String>? favoriteIds,
    List<CarModel>? favoriteCars,
    bool? isLoading,
  }) =>
      FavoritesState(
        favoriteIds: favoriteIds ?? this.favoriteIds,
        favoriteCars: favoriteCars ?? this.favoriteCars,
        isLoading: isLoading ?? this.isLoading,
      );

  bool isFavorite(String? carId) =>
      carId != null && favoriteIds.contains(carId);

  @override
  List<Object?> get props => [favoriteIds, favoriteCars, isLoading];
}