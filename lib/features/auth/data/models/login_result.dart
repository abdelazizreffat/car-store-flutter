import 'package:car_store/core/errors/failures.dart';
import 'package:car_store/features/auth/data/models/responses/user_model.dart';

sealed class LoginResult {
  const LoginResult();
}

final class LoginResultSuccess extends LoginResult {
  final UserModel user;
  const LoginResultSuccess(this.user);
}

// Only emitted when HTTP 403 + requiresVerification == true + non-empty email.
final class LoginResultEmailNotVerified extends LoginResult {
  final String email;
  final String? serverMessage;
  const LoginResultEmailNotVerified({required this.email, this.serverMessage});
}

final class LoginResultFailure extends LoginResult {
  final Failure failure;
  const LoginResultFailure(this.failure);
}
