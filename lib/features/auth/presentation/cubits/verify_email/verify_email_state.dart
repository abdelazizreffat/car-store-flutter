part of 'verify_email_cubit.dart';

sealed class VerifyEmailState extends Equatable {
  const VerifyEmailState();

  @override
  List<Object?> get props => [];
}

final class VerifyEmailInitial extends VerifyEmailState {}

final class VerifyEmailLoading extends VerifyEmailState {}

final class VerifyEmailSuccess extends VerifyEmailState {
  final UserModel user;
  const VerifyEmailSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class VerifyEmailError extends VerifyEmailState {
  final String message;
  const VerifyEmailError(this.message);

  @override
  List<Object?> get props => [message];
}
