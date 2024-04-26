import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateStorePageUseCase
    extends CompletableUseCase< NavStorePageUseCaseParams> {
  final NavigationRepository _navigationRepository;

  NavigateStorePageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
       NavStorePageUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.goToStorePage(params!.context);
      logger.finest(' NavigateStorePageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe(' NavigateStorePageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class NavStorePageUseCaseParams {
  final BuildContext context;

  NavStorePageUseCaseParams(this.context);
}
