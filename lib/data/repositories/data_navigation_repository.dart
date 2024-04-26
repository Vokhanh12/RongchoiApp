import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/shared/utils/form_register.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';

class DataNavigationRepository extends NavigationRepository {
  /// Singleton object of `DataAuthenticationRepository`
  static final DataNavigationRepository _instance =
      DataNavigationRepository._internal();

  late Logger _logger;

  // Constructors
  DataNavigationRepository._internal() {
    _logger = Logger('DataNavigationRepository');
  }

  factory DataNavigationRepository() => _instance;

  @override
  Future<void> goToHomePage(BuildContext context) async {
    // TODO: implement goToHomePage
    // Go to Home Page
    GoRouter.of(context).push('/home');
  }

  @override
  Future<void> goToJobsPage(BuildContext context) async {
    // TODO: implement goToJobsPage
    // Go to Jobs Page
    GoRouter.of(context).push('/jobs');
  }

  @override
  Future<void> goToLoginPage(BuildContext context) async {
    // TODO: implement goToLoginPage
    // Go to Jobs Page
    GoRouter.of(context).push('/login');
  }

  @override
  Future<void> goToMapPage(BuildContext context) async {
    // TODO: implement goToMapPage
    // Go to Jobs Page
    GoRouter.of(context).push('/map');
  }

  @override
  Future<void> goToRegisterPage(BuildContext context) async {
    // TODO: implement goToRegisterPage
    // Go to Jobs Page
    GoRouter.of(context).push('/register');
  }

  @override
  Future<void> goToSplashPage(BuildContext context) async {
    // TODO: implement goToSplashPage
    // Go to Jobs Page
    GoRouter.of(context).push('/splash');
  }

  @override
  Future<void> goToLanguagePage(BuildContext context) async {
    // TODO: implement goToLanguagePage
    GoRouter.of(context).push('/language');
  }

  @override
  Future<void> backNavigationPage(BuildContext context) async {
    // TODO: implement backNavigationPage
    Navigator.of(context).pop();
  }

  @override
  Future<void> goToConRegisPage(
    BuildContext context,
    FormRegister formRegister,
  ) async {
    context.go('/confirm-registration', extra: formRegister);
  }

  @override
  Future<dynamic> goToOtherTab(BuildContext context, int index) async {
    try {
      return [context, index];
    } catch (ex) {
      return ex.toString();
    }
  }

  @override
  Future<void> goToStorePage(BuildContext context) async {
    // TODO: implement goToStorePage
    GoRouter router = GoRouter.of(context);
    router.go(Routes.storeNamePage);
  }

  @override
  Future<void> goToMediaSocialPage(BuildContext context) async {
    // TODO: implement goToMediaSocialPage
    // Go to Jobs Page
    GoRouter.of(context).push(Routes.mediaSocialNamePage);
  }
}
