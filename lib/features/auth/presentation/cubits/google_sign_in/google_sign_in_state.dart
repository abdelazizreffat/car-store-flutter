part of 'google_sign_in_cubit.dart';

sealed class GoogleSignInState extends Equatable {
  const GoogleSignInState();

  @override
  List<Object?> get props => [];
}

final class GoogleSignInInitial extends GoogleSignInState {}

final class GoogleSignInLoading extends GoogleSignInState {}

final class GoogleSignInSuccess extends GoogleSignInState {
  final UserModel user;
  const GoogleSignInSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class GoogleSignInError extends GoogleSignInState {
  final String message;
  const GoogleSignInError(this.message);

  @override
  List<Object?> get props => [message];
}
