
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/functions/navigator.dart';

import '../../app/global_cubit/locale_cubit.dart';
import 'app_strings.dart';

void changeLanguage(context) {
  if (Localizations.localeOf(context).languageCode ==
      AppStrings.englishCode) {
    BlocProvider.of<LocaleCubit>(context).toArabic();
  }else{
    BlocProvider.of<LocaleCubit>(context).toEnglish();
  }
  navigateReplacement(context, '/');
}