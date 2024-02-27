import 'dart:async';

import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rongchoi_app/app/presentation/bloc/language_event.dart';
import 'package:rongchoi_app/app/presentation/bloc/language_state.dart';
import 'package:rongchoi_app/app/utils/constants.dart';



class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageLoaded(Locale(Languages.languages[0].code)));

  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    if (event is ToggleLanguageEvent) {
      yield LanguageLoaded(Locale(event.language.code));
    }
  }
}