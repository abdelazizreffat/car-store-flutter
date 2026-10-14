import 'package:car_store/core/constants/api_constants.dart';
import 'package:car_store/core/constants/storage_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;

  // A separate Dio instance used only for token refresh to avoid recursive interception.
  late final Dio _refreshDio;

  // TODO: Use Completer to handle multiple 401 errors at the same time.
  // Other requests should wait for the first refresh request to finish,
  // then retry with the new access token.
  // This improvement will be added later to keep the code simple for now.

  // Prevents multiple simultaneous refresh requests.
  bool _isRefreshing = false;

  AuthInterceptor({required this._storage}) {
    _refreshDio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {ApiConstants.contentTypeHeader: ApiConstants.contentTypeJson},
      ),
    );
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: StorageKeys.accessTokenKey);
    if (token != null) {
      options.headers[ApiConstants.authorizationHeader] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final path = err.requestOptions.path;
    final statusCode = err.response?.statusCode;

    // Only attempt refresh on 401, and never for auth endpoints themselves.
    final shouldTryRefresh =
        statusCode == 401 &&
        !ApiConstants.skipRefreshPaths.contains(path) &&
        !_isRefreshing;

    if (!shouldTryRefresh) {
      handler.next(err);
      return;
    }

    _isRefreshing = true;

    try {
      final refreshToken = await _storage.read(
        key: StorageKeys.refreshTokenKey,
      );

      if (refreshToken == null) {
        await _clearTokens();
        _isRefreshing = false;
        handler.next(err);
        return;
      }

      // 1. Request a new token pair.
      final refreshResponse = await _refreshDio.post(
        ApiConstants.refreshTokenPath,
        data: {'refreshToken': refreshToken},
      );

      // 2. Read new tokens from response
      final data = refreshResponse.data['data'];
      final newAccessToken = data['accessToken'] as String;
      final newRefreshToken = data['refreshToken'] as String;

      // 3. Save new tokens in storage
      await _storage.write(
        key: StorageKeys.accessTokenKey,
        value: newAccessToken,
      );
      await _storage.write(
        key: StorageKeys.refreshTokenKey,
        value: newRefreshToken,
      );

      // Retry the original request once with the new access token.
      final retryOptions = err.requestOptions;
      retryOptions.headers[ApiConstants.authorizationHeader] =
          'Bearer $newAccessToken';

      final retryResponse = await _refreshDio.fetch(retryOptions);
      _isRefreshing = false;
      handler.resolve(retryResponse);
    } catch (_) {
      // Refresh failed — clear credentials and propagate the original error.
      await _clearTokens();
      _isRefreshing = false;
      handler.next(err);
    }
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: StorageKeys.accessTokenKey);
    await _storage.delete(key: StorageKeys.refreshTokenKey);
  }
}
