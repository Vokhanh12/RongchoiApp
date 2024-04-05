import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateHomePageUseCase extends CompletableUseCase<NavigateHomePageUseCaseParams> {
  final NavigationRepository _navigationRepository;

  NavigateHomePageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(NavigateHomePageUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.goToHomePage(context: params!.context);
      logger.finest('NavigateHomePageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('NavigateHomePageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}


class NavigateHomePageUseCaseParams {

  final BuildContext context;

  NavigateHomePageUseCaseParams (this.context);

}

