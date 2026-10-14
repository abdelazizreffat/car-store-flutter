part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

// Carries the email forward so VerifyEmailView knows where to send the OTP.
final class RegisterSuccess extends RegisterState {
  final String email;
  const RegisterSuccess(this.email);

  @override
  List<Object?> get props => [email];
}

final class RegisterError extends RegisterState {
  final String message;
  const RegisterError(this.message);

  @override
  List<Object?> get props => [message];
}
