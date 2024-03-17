import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/home/home_view.dart';
import 'package:rongchoi_app/app/page/login/login_view.dart';
import 'package:rongchoi_app/app/page/splash/splash_view.dart';

class AppRouter {
// GoRouter configuration
  static var Router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name:
            'splash', // Optional, add name to your routes. Allows you navigate by name instead of path
        path: '/',
        pageBuilder: (_, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: SplashPage(title: 'Splash'),
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          );
        },
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        pageBuilder: (_, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: LoginPage(key: ValueKey('unique_key'), title: 'login'),
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          );
        },
      )
    ],
  );
}
