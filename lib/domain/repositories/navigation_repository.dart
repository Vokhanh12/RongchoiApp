import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rongchoi_app/domain/utils/form_register.dart';

abstract class NavigationRepository {
  Future<void> goToLoginPage({required BuildContext context});

  Future<void> goToRegisterPage({required BuildContext context});

  Future<void> goToLanguagePage({required BuildContext context});


  Future<void> goToHomePage({required BuildContext context});

  Future<void> goToJobsPage({required BuildContext context});

  Future<void> goToStorePage({required BuildContext context});

  Future<void> goToMediaSocialPage({required BuildContext context});

  Future<void> goToOtherTab({required BuildContext context, required String name});



  Future<void> goToConRegisPage({required BuildContext context, required FormRegister formRegister});

  Future<void> backNavigationPage({required BuildContext context});

  Future<void> goToSplashPage(BuildContext context);


  Future<void> goToMapPage(BuildContext context);


  // more .....
}
