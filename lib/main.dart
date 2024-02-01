import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean_architecture;
import 'package:rongchoi_app/app/page/home/home_view.dart';

import 'package:flutter/material.dart';
import 'package:rongchoi_app/app/page/login/login_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    clean_architecture.FlutterCleanArchitecture.debugModeOn();
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const LoginPage(key: ValueKey('unique_key'),title: 'Flutter Clean Demo Page'),
    );
  }
}