import 'package:car_store/core/constants/app_strings.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super(AppStrings.networkError);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super(AppStrings.sessionExpired);
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super(AppStrings.unknownError);
}

// Converts a DioException into a typed Failure, preserving the API error message when available.
Failure dioExceptionToFailure(DioException e) {
  if (e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.connectionTimeout) {
    return const NetworkFailure();
  }

  final statusCode = e.response?.statusCode;
  final apiMessage = e.response?.data?['message'] as String?;

  // Prefer the API's own error message when available.
  // UnauthorizedFailure is reserved for expired sessions detected by the interceptor.
  if (apiMessage != null && apiMessage.isNotEmpty) {
    return ServerFailure(apiMessage);
  }

  if (statusCode == 401) return const UnauthorizedFailure();

  return const UnknownFailure();
}
