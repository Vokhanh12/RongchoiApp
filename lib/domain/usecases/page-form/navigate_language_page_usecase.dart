import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateLanguagePageUseCase extends CompletableUseCase<NavigateLanguagePageUseCaseParams> {
  final NavigationRepository _navigationRepository;

  NavigateLanguagePageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(NavigateLanguagePageUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.goToLanguagePage(context: params!.context);
      logger.finest('NavigateLanguagePageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('NavigateLanguagePageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}


class NavigateLanguagePageUseCaseParams {

  final BuildContext context;

  NavigateLanguagePageUseCaseParams (this.context);

}

