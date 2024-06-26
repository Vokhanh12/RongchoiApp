import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rongchoi_app/shared/utils/form_register.dart';

abstract class NavigationRepository {
  Future<void> goToLoginPage(BuildContext context);

  Future<void> goToRegisterPage(BuildContext context);

  Future<void> goToLanguagePage(BuildContext context);

  Future<void> goToHomePage(BuildContext context);

  Future<void> goToJobPage(BuildContext context);

  Future<void> goToStorePage(BuildContext context);

  Future<void> goToMediaSocialPage(BuildContext context);

  Future<dynamic> goToOtherTab(BuildContext context, int index);

  Future<void> goToConRegisPage(
      BuildContext context, FormRegister formRegister);

  Future<void> backNavigationPage(BuildContext context);

  Future<void> goToSplashPage(BuildContext context);

  Future<void> goToMapPage(BuildContext context);

  Future<void> goToPersonalPage(BuildContext context);


  // more .....
}
