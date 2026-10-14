part of 'verify_reset_otp_cubit.dart';

sealed class VerifyResetOtpState extends Equatable {
  const VerifyResetOtpState();

  @override
  List<Object?> get props => [];
}

final class VerifyResetOtpInitial extends VerifyResetOtpState {}

final class VerifyResetOtpLoading extends VerifyResetOtpState {}

// Carry email + resetToken forward to ResetPassword screen.
final class VerifyResetOtpSuccess extends VerifyResetOtpState {
  final String email;
  final String resetToken;
  const VerifyResetOtpSuccess({required this.email, required this.resetToken});

  @override
  List<Object?> get props => [email, resetToken];
}

final class VerifyResetOtpError extends VerifyResetOtpState {
  final String message;
  const VerifyResetOtpError(this.message);

  @override
  List<Object?> get props => [message];
}
