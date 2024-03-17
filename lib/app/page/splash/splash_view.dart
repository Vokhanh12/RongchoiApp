import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/splash/splash_controller.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/widgets/custom_image.dart';
import 'package:rongchoi_app/app/widgets/custom_svg_picture.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/shared/build_config/screen_size.dart';

class SplashPage extends clean_architecture.View {
  const SplashPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  SplashPageResponsiveViewState createState() =>
      SplashPageResponsiveViewState();
}

class SplashPageResponsiveViewState
    extends clean_architecture.ResponsiveViewState<SplashPage, SplashController>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  SplashPageResponsiveViewState()
      : super(SplashController(DataAuthenticationRepository()));

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget splashScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child, // Provide a default value for child
    );
  }

  @override
  // TODO: implement desktopView
  Widget get desktopView => splashScaffold(
          child: clean_architecture.ControlledWidgetBuilder<SplashController>(
        builder: (context, controller) {
          // init
          controller.initAnimation(_animationController, _animation);
          print("aaa");
          return _body;
        },
      ));

  Stack get _body => Stack(
        alignment: Alignment.center,
        children: [background, logo],
      );

  @override
  // TODO: implement mobileView
  Widget get mobileView => splashScaffold(
          child: clean_architecture.ControlledWidgetBuilder<SplashController>(
        builder: (context, controller) {
          // init
          controller.initAnimation(_animationController, _animation);
          return _body;
        },
      ));


  @override
  // TODO: implement tabletView
  Widget get tabletView => throw UnimplementedError();

  @override
  // TODO: implement watchView
  Widget get watchView => throw UnimplementedError();

  Positioned get background => Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      height: MediaQuery.of(context).size.height,
      child: Container(
        width: ScreenSize.screenWidth,
        height: ScreenSize.screenHeight,
        color: Colors.white,
      ));

  Positioned get logo => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 50,
        left: 0.0,
        right: 0.0,
        child: const CustomSvgPicture(
            url: Resources.logoNotTitile, width: 200, height: 200),
      );
}
