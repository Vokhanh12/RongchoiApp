import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/page/media%20social/media_social_controller.dart';

class MediaSocialPage extends clean_architecture.View {
  const MediaSocialPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  MediaSocialPageResponsiveViewState createState() =>
      MediaSocialPageResponsiveViewState();
}

class MediaSocialPageResponsiveViewState extends clean_architecture
    .ResponsiveViewState<MediaSocialPage, MediaSocialController> {
  MediaSocialPageResponsiveViewState()
      : super(
          MediaSocialController(
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

  Widget mediaSocialScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child, // Provide a default value for child
    );
  }

  Widget _buildMediaSocialFormWidget() {
    return clean_architecture.ControlledWidgetBuilder<MediaSocialController>(
        builder: (context, controller) {
      return Center(
        child: Text("MediaSocialPage"),
      );
    });
  }

  @override
  // TODO: implement mobileView
  Widget get mobileView =>
      clean_architecture.ControlledWidgetBuilder<MediaSocialController>(
          builder: (context, controller) {
        return ModalProgressHUD(
            inAsyncCall: controller.isLoading,
            child: mediaSocialScaffold(
              child: _buildMediaSocialFormWidget(),
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
