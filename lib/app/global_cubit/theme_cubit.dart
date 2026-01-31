import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/app/usecases/change_theme.dart';
import 'package:medical_center/app/usecases/get_saved_theme.dart';
import 'package:medical_center/core/usecases/usecase.dart';

part 'theme_state.dart';

/// Cubit for managing application theme settings (Dark/Light mode).
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required this.getSavedThemeUseCase,
    required this.changeThemeUseCase,
  }) : super(ThemeInitial());

  final GetSavedThemeUseCase getSavedThemeUseCase;
  final ChangeThemeUseCase changeThemeUseCase;

  ThemeMode themeMode = ThemeMode.light;

  /// Retrieves the saved theme preference from storage.
  Future<void> getSavedTheme() async {
    final response = await getSavedThemeUseCase.call(NoParams());
    response.fold(
      (failure) => debugPrint('getSavedThemeUseCase failed'),
      (value) {
        themeMode = value;
        emit(ChangeThemeState(themeMode));
      },
    );
  }

  /// Changes the application theme.
  Future<void> changeTheme(ThemeMode mode) async {
    final response = await changeThemeUseCase.call(mode);
    response.fold(
      (failure) => debugPrint('changeThemeUseCase failed'),
      (value) {
        themeMode = mode;
        emit(ChangeThemeState(themeMode));
      },
    );
  }

  /// Toggles between light and dark mode.
  void toggleTheme() {
    if (themeMode == ThemeMode.light) {
      changeTheme(ThemeMode.dark);
    } else {
      changeTheme(ThemeMode.light);
    }
  }

  /// Checks if current theme is dark.
  bool get isDark => themeMode == ThemeMode.dark;
}
