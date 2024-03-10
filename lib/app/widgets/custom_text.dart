import 'package:flutter/material.dart';
import 'package:rongchoi_app/app/page/home/home_controller.dart';
import 'package:rongchoi_app/shared/build_config/screen_config.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  const CustomText({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    // use a common controller assuming HomePageButton is always a child of Home

 

    return Text(
      this.text,
      style: TextStyle(
        color: const Color(0xFF808080), // Set color to #808080
        fontWeight: FontWeight.bold, // Set text to be bold
        fontSize: this.fontSize, // Set text size to 12
        decoration: TextDecoration.none,
      ),
    );
  }
}
