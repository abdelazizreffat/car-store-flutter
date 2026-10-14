part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserModel user;
  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

// Triggered when the API returns 403 with requiresVerification: true.
// Carries the email so VerifyEmailView can use it directly.
final class LoginEmailNotVerified extends LoginState {
  final String email;
  const LoginEmailNotVerified(this.email);

  @override
  List<Object?> get props => [email];
}

final class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);

  @override
  List<Object?> get props => [message];
}
