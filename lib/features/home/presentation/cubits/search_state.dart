part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchIdle extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<CarModel> results;
  final String query;

  const SearchSuccess(this.results, this.query);

  @override
  List<Object?> get props => [results, query];
}

final class SearchEmpty extends SearchState {
  final String query;
  const SearchEmpty(this.query);

  @override
  List<Object?> get props => [query];
}

final class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}