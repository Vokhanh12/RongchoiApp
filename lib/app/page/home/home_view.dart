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
  HomePageState() : super(HomeController(DataUsersRepository()));

  Widget HomeScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child,
    );
  }

  Widget _buildHomeFormWidget() {
    return Scaffold(
      body: SingleChildScrollView(),
    );
  }

  @override
  // TODO: implement desktopView
  Widget get desktopView => throw UnimplementedError();

  @override
  // TODO: implement mobileView
  Widget get mobileView =>  HomeScaffold(child: _buildHomeFormWidget());

  @override
  // TODO: implement tabletView
  Widget get tabletView => throw UnimplementedError();

  @override
  // TODO: implement watchView
  Widget get watchView => throw UnimplementedError();
}
