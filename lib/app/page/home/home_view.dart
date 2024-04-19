import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/data/repositories/data_navigation_repository.dart';

import './home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import '../../../data/repositories/data_users_repository.dart';

class HomePage extends clean_architecture.View {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() =>
      // inject dependencies inwards
      HomePageState();
}

class HomePageState
    extends clean_architecture.ResponsiveViewState<HomePage, HomeController> {
  HomePageState()
      : super(HomeController(
            DataUsersRepository(), DataAuthenticationRepository(), DataNavigationRepository()));

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
        );
      },
    );
  }


 
  @override
  // TODO: implement desktopView
  Widget get desktopView => throw UnimplementedError();

  @override
  // TODO: implement mobileView
  Widget get mobileView => HomeScaffold(child:   clean_architecture.ControlledWidgetBuilder<HomeController>(
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
