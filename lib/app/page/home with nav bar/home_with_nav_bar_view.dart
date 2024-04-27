import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/page/home%20with%20nav%20bar/home_with_nav_bar_controller.dart';
import 'package:rongchoi_app/app/page/job/job_controller.dart';
import 'package:rongchoi_app/app/page/media%20social/media_social_controller.dart';
import 'package:rongchoi_app/app/widgets/scaffold_with_nav_bar.dart';

class HomeWithNavBarPage extends clean_architecture.View {
  const HomeWithNavBarPage({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;
  @override
  HomeWithNavBarPageResponsiveViewState createState() =>
      HomeWithNavBarPageResponsiveViewState();
}

class HomeWithNavBarPageResponsiveViewState extends clean_architecture
    .ResponsiveViewState<HomeWithNavBarPage, JobController> {
  HomeWithNavBarPageResponsiveViewState()
      : super(
          JobController(
              // DataAuthenticationRepository(),
              //DataNavigationRepository(),
              ),
        );

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget homeWithNavBarScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child, // Provide a default value for child
    );
  }

  Widget _buildHomeWithNavBarFormWidget() {
    return clean_architecture.ControlledWidgetBuilder<HomeWithNavBarController>(
        builder: (context, controller) {
      return ScaffoldWithNavBar(
        child: widget.child,
        
        onTap: (index) {
          

          controller.goToOtherTab(context: context, index: index);

          setState(() {
            _currentIndex = index;
          });

        },

        currentIndex: _currentIndex,
      );
    });
  }

  @override
  // TODO: implement mobileView
  Widget get mobileView =>
      clean_architecture.ControlledWidgetBuilder<HomeWithNavBarController>(
          builder: (context, controller) {
        return ModalProgressHUD(
            inAsyncCall: controller.isLoading,
            child: homeWithNavBarScaffold(
              child: _buildHomeWithNavBarFormWidget(),
            ));
      });

  @override
  // TODO: implement desktopView
  Widget get desktopView => throw UnimplementedError();

  @override
  // TODO: implement tabletView
  Widget get tabletView => throw UnimplementedError();

  @override
  // TODO: implement watchView
  Widget get watchView => throw UnimplementedError();
}
