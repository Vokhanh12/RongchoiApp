
import 'package:flutter/material.dart';

abstract class NavigationRepository{

 Future<void> goToLoginPage({required BuildContext context});

 Future<void> goToRegisterPage({required BuildContext context});

  Future<void> goToLanguagePage({required BuildContext context});

 Future<void> goToSplashPage(BuildContext context);

 Future<void> goToHomePage(BuildContext context);

 Future<void> goToJobsPage(BuildContext context);

 Future<void> goToMapPage(BuildContext context);

 Future<void> goToMediaSocialPage(BuildContext context);

 Future<void> backNavigationPage({required BuildContext context});

  // more .....

}