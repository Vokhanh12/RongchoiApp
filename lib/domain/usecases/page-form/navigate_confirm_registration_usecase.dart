import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateConfirmRegistrationPageUseCase extends CompletableUseCase<NavigateConfirmRegistrationPageUseCaseParams> {
  final NavigationRepository _navigationRepository;

 NavigateConfirmRegistrationPageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(NavigateConfirmRegistrationPageUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.goToConfirmRegistration(context: params!.context);
      logger.finest('NavigateConfirmRegistrationPageUseCaseParams successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('NavigateConfirmRegistrationPageUseCaseParams unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}


class NavigateConfirmRegistrationPageUseCaseParams {

  final BuildContext context;

  NavigateConfirmRegistrationPageUseCaseParams (this.context);

}

