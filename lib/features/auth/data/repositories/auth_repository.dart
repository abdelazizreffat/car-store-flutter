import 'package:car_store/core/errors/failures.dart';
import 'package:car_store/features/auth/data/models/login_result.dart';
import 'package:car_store/features/auth/data/models/requests/login_request_body.dart';
import 'package:car_store/features/auth/data/models/requests/register_request_body.dart';
import 'package:car_store/features/auth/data/models/responses/register_response_model.dart';
import 'package:car_store/features/auth/data/models/responses/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<LoginResult> login(LoginRequestBody body);

  Future<Either<Failure, RegisterResponseData>> register(
    RegisterRequestBody body,
  );

  Future<Either<Failure, UserModel>> verifyEmail({
    required String email,
    required String otp,
  });

  Future<Either<Failure, UserModel>> getCurrentUser();

  Future<bool> hasValidSession();

  Future<void> clearSession();

  Future<Either<Failure, String>> forgotPassword(String email);

  // Returns the resetToken on success.
  Future<Either<Failure, String>> verifyResetOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String newPassword,
  });

  Future<Either<Failure, UserModel>> googleSignIn(String idToken);
}
