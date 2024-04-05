import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateRegisterPageUseCase extends CompletableUseCase<NavigateRegisterPageUseCaseParams> {
  final NavigationRepository _navigationRepository;

  NavigateRegisterPageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(NavigateRegisterPageUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.goToRegisterPage(context: params!.context);
      logger.finest('NavigateRegisterPageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('NavigateRegisterPageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}


class NavigateRegisterPageUseCaseParams {

  final BuildContext context;

  NavigateRegisterPageUseCaseParams (this.context);

}

