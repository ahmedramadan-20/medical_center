import 'package:shared_preferences/shared_preferences.dart';

/// Helper class for managing local cache using SharedPreferences.
///
/// Provides a simplified interface for storing and retrieving data locally.
class CacheHelper {
  CacheHelper({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  /// Get a string value from cache.
  String? getDataString({required String key}) =>
      _sharedPreferences.getString(key);

  /// Get any type of data from cache.
  dynamic getData({required String key}) => _sharedPreferences.get(key);

  /// Save data to cache. Supports String, bool, int, and double types.
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return _sharedPreferences.setBool(key, value);
    }
    if (value is String) {
      return _sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return _sharedPreferences.setInt(key, value);
    }
    return _sharedPreferences.setDouble(key, value);
  }

  /// Remove a specific key-value pair from cache.
  Future<bool> removeData({required String key}) =>
      _sharedPreferences.remove(key);

  /// Check if cache contains a specific key.
  Future<bool> containsKey({required String key}) async =>
      _sharedPreferences.containsKey(key);

  /// Clear all data from cache.
  Future<bool> clearData() => _sharedPreferences.clear();

  /// Save data to cache (alias for saveData with better naming).
  Future<dynamic> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return _sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      return _sharedPreferences.setBool(key, value);
    }
    return _sharedPreferences.setInt(key, value);
  }
}
