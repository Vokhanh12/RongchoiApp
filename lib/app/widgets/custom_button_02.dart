import 'package:rongchoi_app/app/page/home/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';

class CustomButton_02 extends StatefulWidget {
  final String text;
  final Function() onTap;

  const CustomButton_02({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  _CustomButton_02State createState() => _CustomButton_02State();
}

class _CustomButton_02State extends State<CustomButton_02> {
  bool isButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(0, 82, 58, 58),
      child: InkWell(
         onTap: () {
          widget.onTap(); // Call the onTap function if needed
        },
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
          constraints: BoxConstraints(
            maxHeight: 45, // Set the maximum height
          ),
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            color: isButtonClicked ?      Color(0xFFFFCE00)  :  Color(0xFFFFBD3F),
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