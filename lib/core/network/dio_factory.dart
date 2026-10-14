import 'package:car_store/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

import 'auth_interceptor.dart';

class DioFactory {
  DioFactory._();

  static Dio createDio({required AuthInterceptor authInterceptor}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {ApiConstants.contentTypeHeader: ApiConstants.contentTypeJson},
      ),
    );

    dio.interceptors.addAll([
      authInterceptor,
      // Logs requests and responses in debug mode only.
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        // Never log tokens or sensitive headers.
        requestHeader: false,
        responseHeader: false,
      ),
    ]);

    return dio;
  }
}
