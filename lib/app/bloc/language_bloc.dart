import 'dart:async';

import 'package:rongchoi_app/app/bloc/language_event.dart';
import 'package:rongchoi_app/app/bloc/language_state.dart';

class LanguageBloc {
  var state = LanguageState('vi');

  final eventController = StreamController<LanguageEvent>();

  final stateController = StreamController<LanguageState>();

  LanguageBloc() {
    eventController.stream.listen((LanguageEvent event) {
      if (event is changeLanguageVietnamese) {
        state = LanguageState('vi');
        print("change state vi");
      } else if (event is changeLanguageEnglish) {
        state = LanguageState('en');
        print("change state en");
      } else{

          print("Unhandled event: $event");
        }


       // add state mới vào stateController để bên UI nhận được
      stateController.sink.add(state);
    });
  }

  void dispose() {
    stateController.close();
    eventController.close();
  }
}
