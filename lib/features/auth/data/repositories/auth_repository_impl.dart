import 'package:car_store/core/constants/app_strings.dart';
import 'package:car_store/core/errors/failures.dart';
import 'package:car_store/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:car_store/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:car_store/features/auth/data/models/login_result.dart';
import 'package:car_store/features/auth/data/models/requests/forgot_password_request_body.dart';
import 'package:car_store/features/auth/data/models/requests/login_request_body.dart';
import 'package:car_store/features/auth/data/models/requests/register_request_body.dart';
import 'package:car_store/features/auth/data/models/requests/reset_password_request_body.dart';
import 'package:car_store/features/auth/data/models/requests/verify_reset_otp_request_body.dart';
import 'package:car_store/features/auth/data/models/responses/register_response_model.dart';
import 'package:car_store/features/auth/data/models/responses/user_model.dart';
import 'package:car_store/features/auth/data/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  const AuthRepositoryImpl({required this._remote, required this._local});

  @override
  Future<LoginResult> login(LoginRequestBody body) async {
    try {
      final response = await _remote.login(body);
      final data = response.data;

      if (response.success == true &&
          data?.accessToken != null &&
          data?.refreshToken != null &&
          data?.user != null) {
        await _local.saveTokens(
          accessToken: data!.accessToken!,
          refreshToken: data.refreshToken!,
        );
        return LoginResultSuccess(data.user!);
      }

      return LoginResultFailure(
        ServerFailure(response.message ?? AppStrings.loginFailed),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        final raw = e.response?.data;

        if (raw is Map) {
          final innerData = raw['data'];

          if (innerData is Map) {
            final requiresVerification =
                innerData['requiresVerification'] == true;
            final rawEmail = innerData['email'];
            final email = rawEmail is String ? rawEmail.trim() : null;

            // Extract server message only if it's actually a String.
            final rawMessage = raw['message'];
            final serverMessage = rawMessage is String ? rawMessage : null;

            if (requiresVerification && email != null && email.isNotEmpty) {
              return LoginResultEmailNotVerified(
                email: email,
                serverMessage: serverMessage,
              );
            }
          }
        }
      }

      return LoginResultFailure(dioExceptionToFailure(e));
    } catch (_) {
      return const LoginResultFailure(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterResponseData>> register(
    RegisterRequestBody body,
  ) async {
    try {
      final response = await _remote.register(body);
      if (response.success == true && response.data != null) {
        return Right(response.data!);
      }
      return Left(
        ServerFailure(response.message ?? AppStrings.registrationFailed),
      );
    } on DioException catch (e) {
      return Left(dioExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _remote.verifyEmail(email: email, otp: otp);
      final data = response.data;

      if (response.success == true &&
          data?.accessToken != null &&
          data?.refreshToken != null &&
          data?.user != null) {
        await _local.saveTokens(
          accessToken: data!.accessToken!,
          refreshToken: data.refreshToken!,
        );
        return Right(data.user!);
      }

      return Left(
        ServerFailure(response.message ?? AppStrings.verificationFailed),
      );
    } on DioException catch (e) {
      return Left(dioExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final response = await _remote.getCurrentUser();
      final user = response.data?.user;
      if (response.success == true && user != null) {
        return Right(user);
      }
      return Left(
        ServerFailure(response.message ?? AppStrings.failedToFetchUser),
      );
    } on DioException catch (e) {
      return Left(dioExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<bool> hasValidSession() => _local.hasValidSession();

  @override
  Future<void> clearSession() => _local.clearTokens();

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    try {
      final success = await _remote.forgotPassword(
        ForgotPasswordRequestBody(email: email),
      );
      if (success) return const Right('OTP sent successfully.');
      return const Left(UnknownFailure());
    } on DioException catch (e) {
      return Left(dioExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _remote.verifyResetOtp(
        VerifyResetOtpRequestBody(email: email, otp: otp),
      );
      final resetToken = response.data?.resetToken;
      if (response.success == true &&
          resetToken != null &&
          resetToken.isNotEmpty) {
        return Right(resetToken);
      }
      return Left(
        ServerFailure(response.message ?? 'OTP verification failed.'),
      );
    } on DioException catch (e) {
      return Left(dioExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final success = await _remote.resetPassword(
        ResetPasswordRequestBody(email: email, newPassword: newPassword),
      );
      if (success) return const Right(null);
      return const Left(UnknownFailure());
    } on DioException catch (e) {
      return Left(dioExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> googleSignIn(String idToken) async {
    try {
      final response = await _remote.googleSignIn(idToken);
      final data = response.data;

      if (response.success == true &&
          data?.accessToken != null &&
          data?.refreshToken != null &&
          data?.user != null) {
        await _local.saveTokens(
          accessToken: data!.accessToken!,
          refreshToken: data.refreshToken!,
        );
        return Right(data.user!);
      }

      return Left(ServerFailure(response.message ?? 'Google Sign-In failed.'));
    } on DioException catch (e) {
      return Left(dioExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
