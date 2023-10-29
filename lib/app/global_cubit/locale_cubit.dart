import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_strings.dart';

import '../../core/usecases/usecase.dart';
import '../usecases/change_lang.dart';
import '../usecases/get_saved_lang.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLangUseCase changeLangUseCase;

  LocaleCubit(
      {required this.getSavedLangUseCase, required this.changeLangUseCase})
      : super(const ChangeLocaleState(Locale(AppStrings.englishCode)));

  //! get saved language
  String currentLangCode = AppStrings.englishCode;

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold((failure) => debugPrint('getSavedLangUseCase failed'),
        (value) {
      currentLangCode = value;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
  }


  Future<void> _changeLang( String langCode) async {
    final response = await changeLangUseCase.call(langCode);
    response.fold((failure) => debugPrint('getSavedLangUseCase failed'),
            (value) {
          currentLangCode = langCode;
          emit(ChangeLocaleState(Locale(currentLangCode)));
        });
  }


  void toEnglish() => _changeLang(AppStrings.englishCode);
  void toArabic() => _changeLang(AppStrings.arabicCode);
}
