import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateOtherTabInHomePageUseCase extends UseCase<
    NavOtherTabInHomePageUseCaseResponse, NavOtherTabInHomePageUseCaseParams> {
  final NavigationRepository _navigationRepository;

  NavigateOtherTabInHomePageUseCase(this._navigationRepository);

  @override
  Future<Stream<NavOtherTabInHomePageUseCaseResponse?>> buildUseCaseStream(
      NavOtherTabInHomePageUseCaseParams? params) async {
    final controller = StreamController<NavOtherTabInHomePageUseCaseResponse>();
    try {
      // assuming you pass credentials here
      final navResult = await _navigationRepository.goToOtherTab(
          params!.context, params!.index);
      controller.add(NavOtherTabInHomePageUseCaseResponse(navResult[0], navResult[1]));
      logger.finest('NavigateOtherTabInHomePage successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('NavigateOtherTabInHomePage unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class NavOtherTabInHomePageUseCaseParams {
  final BuildContext context;

  final int index;

  NavOtherTabInHomePageUseCaseParams(this.context, this.index);
}

class NavOtherTabInHomePageUseCaseResponse {
  final BuildContext context;
  final int index;

  NavOtherTabInHomePageUseCaseResponse(this.context, this.index);
}
