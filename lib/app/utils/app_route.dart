import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/confirm%20registration/confirm_registration_view.dart';
import 'package:rongchoi_app/app/page/home%20with%20nav%20bar/home_with_nav_bar_view.dart';
import 'package:rongchoi_app/app/page/home/home_view.dart';
import 'package:rongchoi_app/app/page/job/job_view.dart';
import 'package:rongchoi_app/app/page/language/language_view.dart';
import 'package:rongchoi_app/app/page/login/login_view.dart';
import 'package:rongchoi_app/app/page/media%20social/media_social_view.dart';
import 'package:rongchoi_app/app/page/personal/personal_view.dart';
import 'package:rongchoi_app/app/page/register/register_view.dart';
import 'package:rongchoi_app/app/page/splash/splash_view.dart';
import 'package:rongchoi_app/app/page/store/store_view.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static late final GoRouter router;

  @override
  void initState() {
    super.initState();
    router = _buildRouter();
  }

  GoRouter _buildRouter() {
    return GoRouter(
        initialLocation: "/",
        navigatorKey: _rootNavigatorKey,
        routes: [
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
              return HomePage(title: "Home", child: child);
            },
            routes: [
              GoRoute(
                name: 'media-social',
                path: 'media-social',
                builder: (context, state) {
                  return MediaSocialPage(title: 'Media Social Page');
                },
              ),
              GoRoute(
                name: 'job',
                path: 'job',
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: JobPage(title: 'JobPage'),
                    transitionsBuilder: (context, animation, secondaryAnimation,
                            child) =>
                        SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: Offset(0, 0),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeIn)),
                            ),
                            // textDirection:
                            //    leftToRight ? TextDirection.ltr : TextDirection.rtl,
                            child: child),
                  );
                },
              ),
              GoRoute(
                name: 'personal',
                path: 'personal',
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: PersonalPage(title: 'PersonalPage'),
                    transitionsBuilder: (context, animation, secondaryAnimation,
                            child) =>
                        SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: Offset(0.75, 0),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeIn)),
                            ),
                            // textDirection:
                            //    leftToRight ? TextDirection.ltr : TextDirection.rtl,
                            child: child),
                  );
                },
              ),
              GoRoute(
                name: 'store',
                path: 'store',
                builder: (context, state) {
                  return const StorePage(title: 'StorePage');
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
                child: const LoginPage(
                    key: ValueKey('unique_key'), title: 'login'),
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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
