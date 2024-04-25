import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/home/home_controller.dart';
import 'package:rongchoi_app/app/page/language/language_controller.dart';
import 'package:rongchoi_app/app/page/language/language_view.dart';
import 'package:rongchoi_app/app/page/language/cubit/language_cubit.dart';
import 'package:rongchoi_app/app/page/register/form_cubit.dart';
import 'package:rongchoi_app/app/page/register/register_controller.dart';
import 'package:rongchoi_app/app/page/splash/splash_view.dart';
import 'package:rongchoi_app/app/utils/route/app_route.dart';
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
      Provider(create: (_) => LanguageCubit()),
      Provider(create: (_) => FormRegisterCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('vi');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    super.initState();
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
      routerConfig: AppRouter.Router,
    );
  }
}
