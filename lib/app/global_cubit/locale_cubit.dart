import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/app/usecases/change_lang.dart';
import 'package:medical_center/app/usecases/get_saved_lang.dart';
import 'package:medical_center/core/usecases/usecase.dart';
import 'package:medical_center/core/utils/app_strings.dart';

part 'locale_state.dart';

/// Cubit for managing application locale/language settings.
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({
    required this.getSavedLangUseCase,
    required this.changeLangUseCase,
  }) : super(const ChangeLocaleState(Locale(AppStrings.englishCode)));

  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLangUseCase changeLangUseCase;

  String currentLangCode = AppStrings.englishCode;

  /// Retrieves the saved language preference from storage.
  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold(
      (failure) => debugPrint('getSavedLangUseCase failed'),
      (value) {
        currentLangCode = value;
        emit(ChangeLocaleState(Locale(currentLangCode)));
      },
    );
  }

  /// Changes the application language.
  Future<void> _changeLang(String langCode) async {
    final response = await changeLangUseCase.call(langCode);
    response.fold(
      (failure) => debugPrint('changeLangUseCase failed'),
      (value) {
        currentLangCode = langCode;
        emit(ChangeLocaleState(Locale(currentLangCode)));
      },
    );
  }

  /// Changes the language to English.
  void toEnglish() => _changeLang(AppStrings.englishCode);

  /// Changes the language to Arabic.
  void toArabic() => _changeLang(AppStrings.arabicCode);
}
