import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/home/home_view.dart';
import 'package:rongchoi_app/app/page/splash/splash_view.dart';

class AppRouter extends StatelessWidget {
// GoRouter configuration
  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name:
            'splash', // Optional, add name to your routes. Allows you navigate by name instead of path
        path: '/',
        builder: (context, state) => SplashPage(title: 'Splash'),
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => HomePage(title: 'Home'),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
