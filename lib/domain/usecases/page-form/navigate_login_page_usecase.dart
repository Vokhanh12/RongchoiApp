import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateLoginPageUseCase extends CompletableUseCase<NavigateLoginPageUseCaseParams> {
  final NavigationRepository _navigationRepository;

  NavigateLoginPageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(NavigateLoginPageUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.goToLoginPage(params!.context);
      logger.finest('NavigateLoginPageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('NavigateLoginPageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}


class NavigateLoginPageUseCaseParams {

  final BuildContext context;

  NavigateLoginPageUseCaseParams (this.context);

}

