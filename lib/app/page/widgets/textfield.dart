import 'package:rongchoi_app/app/page/home/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';


class CustomTextField extends StatelessWidget {
  final String text;

  const CustomTextField({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        FlutterCleanArchitecture.getController<LoginController>(context);

    return TextField(
      decoration: InputDecoration(
        labelText: 'Hello'
      ),
    );
  }
}