import 'package:flutter/material.dart';
import 'package:medical_center/core/database/cache/cache_helper.dart';

/// Abstract class for theme local data source.
abstract class ThemeLocalDataSource {
  /// Saves the theme mode code to local storage.
  Future<bool> changeTheme({required ThemeMode themeMode});

  /// Retrieves the saved theme mode from local storage.
  Future<String?> getSavedTheme();
}

/// Implementation of theme local data source using CacheHelper.
class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  ThemeLocalDataSourceImpl({required this.cacheHelper});
  final CacheHelper cacheHelper;

  static const String _themeKey = 'APP_THEME';

  @override
  Future<bool> changeTheme({required ThemeMode themeMode}) async =>
      cacheHelper.saveData(key: _themeKey, value: themeMode.name);

  @override
  Future<String?> getSavedTheme() async =>
      cacheHelper.getDataString(key: _themeKey);
}
