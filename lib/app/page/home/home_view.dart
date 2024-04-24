import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/data/repositories/data_navigation_repository.dart';

import './home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import '../../../data/repositories/data_users_repository.dart';

class HomePage extends clean_architecture.View {
  final StatefulNavigationShell navigationShell;

  const HomePage({Key? key, required this.title, required this.navigationShell})
      : super(key: key);

  final String title;

  @override
  HomePageState createState() =>
      // inject dependencies inwards
      HomePageState(navigationShell);
}

class HomePageState
    extends clean_architecture.ResponsiveViewState<HomePage, HomeController> {
  final StatefulNavigationShell navigationShell;

  HomePageState(StatefulNavigationShell navigationShell)
      : navigationShell = navigationShell,
        super(HomeController(DataUsersRepository(),
            DataAuthenticationRepository(), DataNavigationRepository()));

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  Widget HomeScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child,
    );
  }

  Widget _buildHomeFormWidget() {
    return clean_architecture.ControlledWidgetBuilder<HomeController>(
      builder: (context, controller) {
        return Scaffold(
          body: Align(
            alignment: Alignment.center,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                controller.logout();
              },
              child: Text('Logout'),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            destinations: const [
              // the appearance of each tab is defined with a [NavigationDestination] widget
              NavigationDestination(label: 'Section A', icon: Icon(Icons.home)),
              NavigationDestination(
                  label: 'Section B', icon: Icon(Icons.settings)),
            ],
            onDestinationSelected: _goBranch,
          ),
        );
      },
    );
  }

  @override
  // TODO: implement desktopView
  Widget get desktopView => throw UnimplementedError();

  @override
  // TODO: implement mobileView
  Widget get mobileView => HomeScaffold(
        child: clean_architecture.ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
            return ModalProgressHUD(
                inAsyncCall: controller.isLoading,
                child: _buildHomeFormWidget());
          },
        ),
      );

  @override
  // TODO: implement tabletView
  Widget get tabletView => throw UnimplementedError();

  @override
  // TODO: implement watchView
  Widget get watchView => throw UnimplementedError();
}
