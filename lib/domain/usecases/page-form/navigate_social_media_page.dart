import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateMediaSocialPageUseCase
    extends CompletableUseCase<NavMediaSocialPageUseCaseParams> {
  final NavigationRepository _navigationRepository;

  NavigateMediaSocialPageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      NavMediaSocialPageUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.goToMediaSocialPage(params!.context);
      logger.finest('NavigateMediaSocialPageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('NavigateMediaSocialPageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class NavMediaSocialPageUseCaseParams {
  final BuildContext context;

  NavMediaSocialPageUseCaseParams(this.context);
}
