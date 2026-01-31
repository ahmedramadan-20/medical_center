import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:medical_center/app/repositories/theme_repository.dart';
import 'package:medical_center/core/errors/failures.dart';
import 'package:medical_center/core/usecases/usecase.dart';

/// Use case for retrieving the saved theme preference.
class GetSavedThemeUseCase implements UseCase<ThemeMode, NoParams> {
  GetSavedThemeUseCase({required this.themeRepository});
  final ThemeRepository themeRepository;

  @override
  Future<Either<Failure, ThemeMode>> call(NoParams params) =>
      themeRepository.getSavedTheme();
}
