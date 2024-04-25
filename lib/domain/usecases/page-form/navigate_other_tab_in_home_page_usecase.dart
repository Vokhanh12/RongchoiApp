import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class NavigateOtherTabInHomePageUseCase extends UseCase<NavigateOtherTabInHomePageUseCaseUseCaseParams> {
  final NavigationRepository _navigationRepository;

  NavigateOtherTabInHomePageUseCase(this._navigationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(NavigateOtherTabInHomePageUseCaseUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _navigationRepository.goToOtherTab(context: params!.context, name: params!.name);
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

class NavigateOtherTabInHomePageUseCaseUseCaseParams {

  final BuildContext context;

  final String name;


  NavigateOtherTabInHomePageUseCaseUseCaseParams(this.context, this.name);

}

abstract class NavigatePage{

  


}




  static const List<MyCustomBottomNavBarItem> tabs = [
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.home),
      activeIcon: Icon(Icons.home),
      label: 'HOME',
      initialLocation: Routes.homeNamePage,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: 'STORE',
      initialLocation: Routes.storeNamePage,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.storefront_outlined),
      activeIcon: Icon(Icons.storefront),
      label: 'JOBS',
      initialLocation: Routes.jobsNamePage,
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.account_circle_outlined),
      activeIcon: Icon(Icons.account_circle),
      label: Routes.mediaSocialNamePage,
      initialLocation: '/media-social',
    ),
  ];

