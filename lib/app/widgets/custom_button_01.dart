import 'package:rongchoi_app/app/page/home/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';

class CustomButton_01 extends StatefulWidget {

  final String text;
  final Function() onTap;

  const CustomButton_01({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  _CustomButton_01State createState() => _CustomButton_01State();
}

class _CustomButton_01State extends State<CustomButton_01> {
  bool isButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: InkWell(

        onTap: widget.onTap,
   
        onTapDown: (details) {
          setState(() {
            isButtonClicked = true;
          });
        },
        onTapUp: (details) {
          setState(() {
            isButtonClicked = false;
          });
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: screenHeight / 18,
          constraints: BoxConstraints(
            maxHeight: 45, // Set the maximum height
          ),
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            color: isButtonClicked ? Color(0xFFFFCE00) : Color(0xFFFF8C00),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ),
    );
  }
}
