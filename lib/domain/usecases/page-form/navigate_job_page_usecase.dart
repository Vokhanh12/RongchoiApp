import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateJobPageUseCase
    extends CompletableUseCase< NavJobPageUseCaseParams> {
  final NavigationRepository _navigationRepository;

  NavigateJobPageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      NavJobPageUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.goToJobPage(params!.context);
      logger.finest('NavigateJobPageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('NavigateJobPageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class NavJobPageUseCaseParams {
  final BuildContext context;

  NavJobPageUseCaseParams(this.context);
}
