import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/app/global_cubit/locale_cubit.dart';
import 'package:medical_center/core/utils/app_strings.dart';

/// Changes the application language between English and Arabic.
void changeLanguage(BuildContext context) {
  final localeCubit = BlocProvider.of<LocaleCubit>(context);

  if (Localizations.localeOf(context).languageCode == AppStrings.englishCode) {
    localeCubit.toArabic();
  } else {
    localeCubit.toEnglish();
  }
}
