import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/main_page.dart';
import 'package:rongchoi_app/app/page/home/home_view.dart';
import 'package:rongchoi_app/app/page/not_found_page.dart';
import 'package:rongchoi_app/app/utils/constants.dart';

import '../../presentation/cubit/navigation_cubit.dart';

class AppRouter {

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.homeNamePage,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => NavigationCubit(),
            child: MainScreen(screen: child),
          );
        },
        routes: [
          GoRoute(
            path: Routes.homeNamePage,
            pageBuilder: (context, state) =>
            const NoTransitionPage(
              child: HomePage(
                key:ValueKey('unique_key'),
                title: 'homepage'),
            ),
           
          ),
          
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),

  );

  static GoRouter get router => _router;
}