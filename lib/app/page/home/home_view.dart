import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/page/home%20with%20nav%20bar/home_with_nav_bar_view.dart';
import 'package:rongchoi_app/app/widgets/scaffold_with_nav_bar.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/data/repositories/data_navigation_repository.dart';

import './home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import '../../../data/repositories/data_users_repository.dart';

class HomePage extends clean_architecture.View {
  const HomePage({Key? key, required this.title, required this.child}) : super(key: key);

  final String title;
  final Widget child;

  @override
  HomePageState createState() =>
      // inject dependencies inwards
      HomePageState();
}

class HomePageState
    extends clean_architecture.ResponsiveViewState<HomePage, HomeController> {
  HomePageState()
      : super(HomeController(DataUsersRepository(),
            DataAuthenticationRepository(), DataNavigationRepository()));

  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget homeScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child,
    );
  }

  Widget _buildHomeFormWidget() {
    const labelStyle = TextStyle(fontFamily: 'Roboto');
    return clean_architecture.ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
      return HomeWithNavBarPage(title: "HomeWithNavPage", child: widget.child);
    });
  }

  @override
  // TODO: implement desktopView
  Widget get desktopView => throw UnimplementedError();

  @override
  // TODO: implement mobileView
  Widget get mobileView =>
      clean_architecture.ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading,
          child: homeScaffold(
            child: _buildHomeFormWidget(),
          ),
        );
      });

  @override
  // TODO: implement tabletView
  Widget get tabletView => throw UnimplementedError();

  @override
  // TODO: implement watchView
  Widget get watchView => throw UnimplementedError();
}
