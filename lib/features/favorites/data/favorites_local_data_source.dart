// Favorites are LOCAL-ONLY. No server favorites endpoint was found in the API docs.
// Data persists across app restarts using flutter_secure_storage (already in pubspec).
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _kFavoritesKey = 'favorites_car_ids';

class FavoritesLocalDataSource {
  final FlutterSecureStorage _storage;

  const FavoritesLocalDataSource(this._storage);

  Future<Set<String>> getFavoriteIds() async {
    final raw = await _storage.read(key: _kFavoritesKey);
    if (raw == null || raw.isEmpty) return {};
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.whereType<String>().toSet();
    } catch (_) {
      return {};
    }
  }

  Future<void> _save(Set<String> ids) async {
    await _storage.write(
      key: _kFavoritesKey,
      value: jsonEncode(ids.toList()),
    );
  }

  Future<void> addFavorite(String carId) async {
    final ids = await getFavoriteIds();
    ids.add(carId);
    await _save(ids);
  }

  Future<void> removeFavorite(String carId) async {
    final ids = await getFavoriteIds();
    ids.remove(carId);
    await _save(ids);
  }

  Future<bool> isFavorite(String carId) async {
    final ids = await getFavoriteIds();
    return ids.contains(carId);
  }
}