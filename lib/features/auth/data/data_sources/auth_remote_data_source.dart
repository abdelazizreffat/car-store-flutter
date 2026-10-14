import 'package:car_store/core/constants/api_constants.dart';
import 'package:car_store/features/auth/data/models/requests/forgot_password_request_body.dart';
import 'package:car_store/features/auth/data/models/requests/login_request_body.dart';
import 'package:car_store/features/auth/data/models/requests/register_request_body.dart';
import 'package:car_store/features/auth/data/models/requests/reset_password_request_body.dart';
import 'package:car_store/features/auth/data/models/requests/verify_reset_otp_request_body.dart';
import 'package:car_store/features/auth/data/models/responses/auth_response_model.dart';
import 'package:car_store/features/auth/data/models/responses/register_response_model.dart';
import 'package:car_store/features/auth/data/models/responses/verify_reset_otp_response.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  const AuthRemoteDataSource({required this._dio});

  Future<RegisterResponseModel> register(RegisterRequestBody body) async {
    final response = await _dio.post(
      ApiConstants.registerPath,
      data: body.toJson(),
    );
    return RegisterResponseModel.fromJson(response.data);
  }

  Future<AuthResponseModel> login(LoginRequestBody body) async {
    final response = await _dio.post(
      ApiConstants.loginPath,
      data: body.toJson(),
    );
    return AuthResponseModel.fromJson(response.data);
  }

  Future<AuthResponseModel> verifyEmail({
    required String email,
    required String otp,
  }) async {
    final response = await _dio.post(
      ApiConstants.verifyEmailPath,
      data: {'email': email, 'otp': otp},
    );
    return AuthResponseModel.fromJson(response.data);
  }

  Future<AuthResponseModel> getCurrentUser() async {
    // Token is attached automatically by AuthInterceptor.
    final response = await _dio.get(ApiConstants.mePath);
    return AuthResponseModel.fromJson(response.data);
  }

  Future<bool> forgotPassword(ForgotPasswordRequestBody body) async {
    final response = await _dio.post(
      ApiConstants.forgotPasswordPath,
      data: body.toJson(),
    );
    return response.data['success'] == true;
  }

  Future<VerifyResetOtpResponse> verifyResetOtp(
    VerifyResetOtpRequestBody body,
  ) async {
    final response = await _dio.post(
      ApiConstants.verifyResetOtpPath,
      data: body.toJson(),
    );
    return VerifyResetOtpResponse.fromJson(response.data);
  }

  Future<bool> resetPassword(ResetPasswordRequestBody body) async {
    final response = await _dio.post(
      ApiConstants.resetPasswordPath,
      data: body.toJson(),
    );
    return response.data['success'] == true;
  }

  Future<AuthResponseModel> googleSignIn(String idToken) async {
    final response = await _dio.post(
      ApiConstants.googleSignIn,
      data: {'idToken': idToken},
    );
    return AuthResponseModel.fromJson(response.data);
  }
}
