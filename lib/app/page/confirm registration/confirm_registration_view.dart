import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/splash/splash_controller.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/widgets/custom_image.dart';
import 'package:rongchoi_app/app/widgets/custom_svg_picture.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/data/repositories/data_navigation_repository.dart';
import 'package:rongchoi_app/device/repositories/device_location_repository.dart';
import 'package:rongchoi_app/shared/build_config/screen_size.dart';

class ConfirmRegistrationPage extends clean_architecture.View {
  const ConfirmRegistrationPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  ConfirmRegistrationPageResponsiveViewState createState() =>
      ConfirmRegistrationPageResponsiveViewState();
}

class ConfirmRegistrationPageResponsiveViewState extends clean_architecture
    .ResponsiveViewState<ConfirmRegistrationPage, ConfirmRegistrationController>
 {


  ConfirmRegistrationPageResponsiveViewState()
      : super(ConfirmRegistrationController());

  @override
  void initState() {
    super.initState();
 
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget confirmRegistrationScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child, // Provide a default value for child
    );
  }

  Widget _buildRegisterFormWidget() {
    return SingleChildScrollView();
  }

  @override
  // TODO: implement mobileView
  Widget get mobileView => confirmRegistrationScaffold(
    child: _buildRegisterFormWidget()
  )

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
