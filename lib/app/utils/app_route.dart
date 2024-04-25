import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/confirm%20registration/confirm_registration_view.dart';
import 'package:rongchoi_app/app/page/home/home_view.dart';
import 'package:rongchoi_app/app/page/job/jobs_view.dart';
import 'package:rongchoi_app/app/page/language/language_view.dart';
import 'package:rongchoi_app/app/page/login/login_view.dart';
import 'package:rongchoi_app/app/page/media%20social/media_social_view.dart';
import 'package:rongchoi_app/app/page/register/register_view.dart';
import 'package:rongchoi_app/app/page/splash/splash_view.dart';
import 'package:rongchoi_app/app/page/store/store_view.dart';
import 'package:rongchoi_app/app/widgets/scaffold_with_nav_bar.dart';
import 'package:rongchoi_app/data/repositories/data_navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_splash_page_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// AppRouter use Presenter
class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static var Router =
      GoRouter(initialLocation: "/", navigatorKey: _rootNavigatorKey, routes: [
    GoRoute(
      name:
          'splash', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      pageBuilder: (_, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const SplashPage(title: 'Splash'),
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          name: 'home',
          path: '/home', // Thêm ký tự '/' ở đầu đường dẫn
          builder: (context, state) {
            return const HomePage(title: 'HomePage');
          },
        ),
        GoRoute(
          name: 'jobs',
          path: '/jobs',
          builder: (context, state) {
            return const JobsPage(title: 'JobPage');
          },
        ),
        GoRoute(
          name: 'store',
          path: '/store',
          builder: (context, state) {
            return const StorePage(title: 'StorePage');
          },
        ),
        GoRoute(
          name: 'media-social',
          path: '/media-social',
          builder: (context, state) {
            return const MediaSocialPage(title: 'Media Social Page');
          },
        ),
      ],
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      pageBuilder: (_, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(key: ValueKey('unique_key'), title: 'login'),
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      },
    ),
    GoRoute(
      name: 'language',
      path: '/language',
      pageBuilder: (_, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const LanguagePage(key: ValueKey('unique_key')),
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      },
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      pageBuilder: (_, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const RegisterPage(
            key: ValueKey('unique_key'),
            title: 'Register',
          ),
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      },
    ),
    GoRoute(
      name: 'confirm-registration', // Tên của tuyến đi
      path: '/confirm-registration', // Đường dẫn của tuyến đi

      pageBuilder: (_, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ConfirmRegistrationPage(
            title: "confirm-registration",
          ),
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      },
    ),
  ]);
}
