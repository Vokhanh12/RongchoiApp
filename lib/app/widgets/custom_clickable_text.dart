import 'package:flutter/material.dart';

class CustomClickableText extends StatelessWidget {

  final String text;

  final Function() onTap;


  const CustomClickableText({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size..height;
  
    return GestureDetector(
      onTap: onTap,
      child: Text(
        this.text,
        style:  TextStyle(
          color: Color(0xFF808080), // Set color to #808080
          fontWeight: FontWeight.bold, // Set text to be bold
          fontSize: 14.0, // Set text size to 12
          decoration: TextDecoration.none,
        ),
      ),
    );
    ;
  }
}
