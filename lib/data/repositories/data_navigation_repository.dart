import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
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
  Future<void> goToHomePage({required BuildContext context}) async {
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
  Future<void> goToLoginPage({required BuildContext context}) async {
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
  Future<void> goToMediaSocialPage(BuildContext context) async {
    // TODO: implement goToMediaSocialPage
    // Go to Jobs Page
    GoRouter.of(context).push('/MediaSocial');
  }

  @override
  Future<void> goToRegisterPage({required BuildContext context}) async {
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
  Future<void> goToLanguagePage({required BuildContext context}) async {
    // TODO: implement goToLanguagePage
    GoRouter.of(context).push('/language');
  }

  @override
  Future<void> backNavigationPage({required BuildContext context}) async {
    // TODO: implement backNavigationPage
    Navigator.of(context).pop();
  }
  
  @override
  Future<void> goToConfirmRegistration({required BuildContext context}) {
    // TODO: implement goToConfirmRegistration
    throw UnimplementedError();
  }
}
