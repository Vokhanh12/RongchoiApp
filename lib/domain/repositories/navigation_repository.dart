import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class NavigationRepository {
  Future<void> goToLoginPage({required BuildContext context});

  Future<void> goToRegisterPage({required BuildContext context});

  Future<void> goToLanguagePage({required BuildContext context});

  Future<void> goToHomePage({required BuildContext context});

  Future<void> goToConfirmRegistration({required BuildContext context});

  Future<void> backNavigationPage({required BuildContext context});

  Future<void> goToSplashPage(BuildContext context);

  Future<void> goToJobsPage(BuildContext context);

  Future<void> goToMapPage(BuildContext context);

  Future<void> goToMediaSocialPage(BuildContext context);

  // more .....
}
