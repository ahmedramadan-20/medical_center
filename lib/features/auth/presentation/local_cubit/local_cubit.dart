import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'local_state.dart';

class LocalCubit extends Cubit<LocalState> {
  LocalCubit() : super(const ChangeLocalState(Locale('en')));

  void updateLocale(Locale locale) {
    if (locale.languageCode != state.locale.languageCode) {
      emit(ChangeLocalState(locale));

    }
    emit(ChangeLocalState(locale));
  }

}
