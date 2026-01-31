part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class ChangeThemeState extends ThemeState {
  const ChangeThemeState(this.themeMode);
  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}
