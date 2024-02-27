import 'dart:ffi';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/presentation/bloc/language_bloc.dart';
import 'package:rongchoi_app/app/presentation/bloc/language_state.dart';
import 'package:rongchoi_app/app/page/home/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/page/login/login_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/widgets/screen_config.dart';
import 'package:rongchoi_app/app/widgets/screen_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

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
    final appLocalization = AppLocalizations.of(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Use to setting singleton pattern
    ScreenSize.init(context);
    ScreenConfig.init(screenWidth, screenHeight);

    clean_architecture.FlutterCleanArchitecture.debugModeOn();

    return MaterialApp(
      locale: _locale,
      title: 'Flutter Demo',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi'), // Tieng Viet
        Locale('en'),
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
      home: LoginPage(
        key: ValueKey('unique_key'),
        title: 'Flutter Clean Demo Page',
        bloc: null,
      ),
    );
  }
}
