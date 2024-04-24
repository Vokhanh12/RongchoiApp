import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/page/job/jobs_controller.dart';
import 'package:rongchoi_app/app/page/media%20social/media_social_controller.dart';
import 'package:rongchoi_app/app/page/store/store_controller.dart';

class StorePage extends clean_architecture.View {
  const StorePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  StorePageResponsiveViewState createState() =>
      StorePageResponsiveViewState();
}

class StorePageResponsiveViewState extends clean_architecture
    .ResponsiveViewState<StorePage, StoreController> {
  StorePageResponsiveViewState()
      : super(
          StoreController(
              // DataAuthenticationRepository(),
              //DataNavigationRepository(),
              ),
        );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget storeScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child, // Provide a default value for child
    );
  }

  Widget _buildStoreFormWidget() {
    return clean_architecture.ControlledWidgetBuilder<StoreController>(
        builder: (context, controller) {
      return Center(
        child: Text("StorePage"),
      );
    });
  }

  @override
  // TODO: implement mobileView
  Widget get mobileView =>
      clean_architecture.ControlledWidgetBuilder<StoreController>(
          builder: (context, controller) {
        return ModalProgressHUD(
            inAsyncCall: controller.isLoading,
            child: storeScaffold(
              child: _buildStoreFormWidget(),
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
