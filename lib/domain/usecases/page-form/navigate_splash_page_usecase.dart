import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateSplashPageUseCase extends CompletableUseCase<NavigateSplashPageUseCaseParams> {
  final NavigationRepository _navigationRepository;

  NavigateSplashPageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(NavigateSplashPageUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.goToSplashPage(params!.context);
      logger.finest('NavigateSplashPageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('NavigateSplashPageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}


class NavigateSplashPageUseCaseParams {

  final BuildContext context;

  NavigateSplashPageUseCaseParams (this.context);

}

