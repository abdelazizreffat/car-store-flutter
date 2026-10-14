part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

// OTP sent — carry email forward to the next screen.
final class ForgotPasswordOtpSent extends ForgotPasswordState {
  final String email;
  const ForgotPasswordOtpSent(this.email);

  @override
  List<Object?> get props => [email];
}

final class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  const ForgotPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
