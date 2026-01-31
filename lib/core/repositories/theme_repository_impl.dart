import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:medical_center/app/repositories/theme_repository.dart';
import 'package:medical_center/core/database/cache/theme_local_data_source.dart';
import 'package:medical_center/core/errors/exceptions.dart';
import 'package:medical_center/core/errors/failures.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl({required this.themeLocalDataSource});
  final ThemeLocalDataSource themeLocalDataSource;

  @override
  Future<Either<Failure, bool>> changeTheme(
      {required ThemeMode themeMode}) async {
    try {
      final isChanged =
          await themeLocalDataSource.changeTheme(themeMode: themeMode);
      return Right(isChanged);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ThemeMode>> getSavedTheme() async {
    try {
      final themeName = await themeLocalDataSource.getSavedTheme();
      if (themeName == null) {
        return const Right(ThemeMode.light); // Default theme
      }

      final themeMode = ThemeMode.values.firstWhere(
        (e) => e.name == themeName,
        orElse: () => ThemeMode.light,
      );

      return Right(themeMode);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
