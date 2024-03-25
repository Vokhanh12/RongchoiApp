import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class BackNavigationPageUseCase extends CompletableUseCase<BackNavigationPageUseCaseParams> {
  final NavigationRepository _navigationRepository;

  BackNavigationPageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(BackNavigationPageUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.backNavigationPage(context: params!.context);
      logger.finest('BackNavigationPageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('BackNavigationPageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}


class BackNavigationPageUseCaseParams {

  final BuildContext context;

  BackNavigationPageUseCaseParams (this.context);

}

