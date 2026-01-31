import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:medical_center/core/errors/failures.dart';

/// Repository interface for theme management operations.
abstract class ThemeRepository {
  /// Retrieves the saved theme mode from local storage.
  Future<Either<Failure, ThemeMode>> getSavedTheme();

  /// Saves the selected theme mode to local storage.
  Future<Either<Failure, bool>> changeTheme({required ThemeMode themeMode});
}
