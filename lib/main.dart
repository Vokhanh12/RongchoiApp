import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/confirm%20registration/confirm_registration_view.dart';
import 'package:rongchoi_app/app/page/home%20with%20nav%20bar/home_with_nav_bar_controller.dart';
import 'package:rongchoi_app/app/page/home%20with%20nav%20bar/home_with_nav_bar_view.dart';
import 'package:rongchoi_app/app/page/home/home_controller.dart';
import 'package:rongchoi_app/app/page/job/job_controller.dart';
import 'package:rongchoi_app/app/page/job/job_view.dart';
import 'package:rongchoi_app/app/page/language/language_controller.dart';
import 'package:rongchoi_app/app/page/language/language_view.dart';
import 'package:rongchoi_app/app/page/language/cubit/language_cubit.dart';
import 'package:rongchoi_app/app/page/media%20social/advertisement_controller.dart';
import 'package:rongchoi_app/app/page/media%20social/advertisement_view.dart';
import 'package:rongchoi_app/app/page/personal/personal_controller.dart';
import 'package:rongchoi_app/app/page/personal/personal_view.dart';
import 'package:rongchoi_app/app/page/register/form_cubit.dart';
import 'package:rongchoi_app/app/page/register/register_controller.dart';
import 'package:rongchoi_app/app/page/register/register_view.dart';
import 'package:rongchoi_app/app/page/splash/splash_view.dart';
import 'package:rongchoi_app/app/page/store/store_controller.dart';
import 'package:rongchoi_app/app/page/store/store_view.dart';
import 'package:rongchoi_app/app/utils/app_route.dart';
import 'package:rongchoi_app/app/page/home/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/page/login/login_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/data/repositories/data_navigation_repository.dart';
import 'package:rongchoi_app/data/repositories/data_setting_repository.dart';
import 'package:rongchoi_app/data/repositories/data_users_repository.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/shared/build_config/config_font_size.dart';
import 'package:rongchoi_app/shared/build_config/screen_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => LanguageController(
              DataSettingRepository(), DataNavigationRepository())),
      ChangeNotifierProvider(
          create: (_) => LoginController(
              DataAuthenticationRepository(), DataNavigationRepository())),
      ChangeNotifierProvider(
          create: (_) => RegisterController(
              DataAuthenticationRepository(), DataNavigationRepository())),
      // Các provider khác nếu cần
      ChangeNotifierProvider(
          create: (_) => HomeController(DataUsersRepository(),
              DataAuthenticationRepository(), DataNavigationRepository())),
      ChangeNotifierProvider(
          create: (_) => HomeWithNavBarController(DataNavigationRepository())),
      ChangeNotifierProvider(
          create: (_) => PersonalController(
              DataAuthenticationRepository(), DataNavigationRepository())),
      ChangeNotifierProvider(create: (_) => JobController()),
      ChangeNotifierProvider(create: (_) => AdvertisementController()),
      ChangeNotifierProvider(create: (_) => JobController()),
      ChangeNotifierProvider(create: (_) => StoreController()),
      Provider(create: (_) => LanguageCubit()),
      Provider(create: (_) => FormRegisterCubit()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static late final GoRouter router;
  int indexMenu = 0; // set current 0

  Locale _locale = Locale('vi');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    super.initState();
    router = _buildRouter();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Use to setting singleton pattern
    ScreenSize.init(context);
    ConfigFontSize.init(screenWidth, screenHeight);

    clean_architecture.FlutterCleanArchitecture.debugModeOn();

    return MaterialApp.router(
        locale: _locale,
        title: 'Flutter Demo',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('vi'),
          Locale('en'),
          Locale('ja'),
          Locale('en_GB'),
          Locale('fr'),
          Locale('de'),
        ],
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        routerConfig: router);
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
          GoRoute(
            path: Routes.homeNamePage,
            redirect: (context, state) => state.path == Routes.homeNamePage
                ? Routes.advertisementNamePage
                : null,
          ),
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return HomePage(title: "HomePage", child: child);
            },
            routes: [
              GoRoute(
                name: 'Advertisement',
                path: Routes.advertisementNamePage,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: const AdvertisementPage(title: 'Advertisement'),
                    transitionDuration: const Duration(seconds: 1),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  );
                },
              ),
              GoRoute(
                name: 'store',
                path: Routes.storeNamePage,
                pageBuilder: (context, state) {
                  const INDEX = 1;

                  return CustomTransitionPage(
                      key: state.pageKey,
                      child: const StorePage(title: 'StorePage'),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: () {
                                  // Define your condition here
                                  if (indexMenu < INDEX) {
                                    indexMenu = INDEX;
                                       return Offset(-0.75, 0.0);
                                  } else {
                                    indexMenu = INDEX;
                                 
                                    return Offset(0.75, 0.0);
                                  }
                                }(),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeIn)),
                            ),
                            // textDirection:
                            //    leftToRight ? TextDirection.ltr : TextDirection.rtl,
                            child: child);
                      });
                },
              ),
              GoRoute(
                name: 'job',
                path: Routes.jobsNamePage,
                pageBuilder: (context, state) {
                  const INDEX = 2;

                  return CustomTransitionPage(
                      key: state.pageKey,
                      child: JobPage(title: 'JobPage'),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: () {
                                  // Define your condition here
                                  if (indexMenu < INDEX) {
                                    indexMenu = INDEX;
                                    return Offset(0.75, 0.0);
                                  } else {
                                    indexMenu = INDEX;
                                    return Offset(-0.75, 0.0);
                                  }
                                }(),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeIn)),
                            ),
                            // textDirection:
                            //    leftToRight ? TextDirection.ltr : TextDirection.rtl,
                            child: child);
                      });
                },
              ),
              GoRoute(
                name: 'personal',
                path: Routes.personalNamePage,
                pageBuilder: (context, state) {
                  const INDEX = 3;

                  return CustomTransitionPage(
                      key: state.pageKey,
                      child: PersonalPage(title: 'PersonalPage'),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: () {
                                  // Define your condition here
                                  if (indexMenu < INDEX) {
                                    indexMenu = INDEX;
                                    return Offset(0.75, 0.0);
                                  } else {
                                    indexMenu = INDEX;
                                    return Offset(-0.75, 0.0);
                                  }
                                }(),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeIn)),
                            ),
                            // textDirection:
                            //    leftToRight ? TextDirection.ltr : TextDirection.rtl,
                            child: child);
                      });
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
}
