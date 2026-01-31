import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:medical_center/app/repositories/theme_repository.dart';
import 'package:medical_center/core/errors/failures.dart';
import 'package:medical_center/core/usecases/usecase.dart';

/// Use case for changing the application theme.
class ChangeThemeUseCase implements UseCase<bool, ThemeMode> {
  ChangeThemeUseCase({required this.themeRepository});
  final ThemeRepository themeRepository;

  @override
  Future<Either<Failure, bool>> call(ThemeMode themeMode) =>
      themeRepository.changeTheme(themeMode: themeMode);
}
