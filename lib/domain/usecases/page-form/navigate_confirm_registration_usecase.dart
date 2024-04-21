import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/entities/form_register.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateConfirmRegistrationPageUseCase extends CompletableUseCase< NavConRegisPageUseCaseParams> {
  final NavigationRepository _navigationRepository;

 NavigateConfirmRegistrationPageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream( NavConRegisPageUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.goToConRegisPage(context: params!.context, formRegister: params!.form);
      logger.finest('NavigateConfirmRegistrationPageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('NavigateConfirmRegistrationPageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}


class NavConRegisPageUseCaseParams {

  final BuildContext context;

  final FormRegister form;

   NavConRegisPageUseCaseParams(this.context, this. form);

}

