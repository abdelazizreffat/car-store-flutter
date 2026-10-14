import 'package:car_store/core/constants/storage_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage _storage;

  const AuthLocalDataSource({required this._storage});

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _storage.write(key: StorageKeys.accessTokenKey, value: accessToken),
      _storage.write(key: StorageKeys.refreshTokenKey, value: refreshToken),
    ]);
  }

  Future<String?> getAccessToken() =>
      _storage.read(key: StorageKeys.accessTokenKey);

  Future<bool> hasValidSession() async {
    final token = await _storage.read(key: StorageKeys.accessTokenKey);
    return token != null;
  }

  // Clears all stored credentials on logout or session expiry.
  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: StorageKeys.accessTokenKey),
      _storage.delete(key: StorageKeys.refreshTokenKey),
    ]);
  }
}
