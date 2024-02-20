import 'package:rongchoi_app/app/page/home/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final double fontSize;
  final TextEditingController controller;

  const CustomTextField({Key? key, required this.text, required this.fontSize, required this.controller}) : super(key: key);

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<CustomTextField> {
  bool _isTextColorChange = false;
  bool _isInputEmpty = true;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _isTextColorChange = false;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;




    return Container(

      height: screenHeight / 18,


      constraints: BoxConstraints(
        maxHeight: 65, // Set the maximum height
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        decoration: _buildInputDecoration(),
        onTap: _handleTap,
        onChanged: _handleTextChange,
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      labelText: widget.text,
      labelStyle: _getLabelStyle(),
      focusedBorder: _getFocusedInputBorder(),
      enabledBorder: _getEnabledInputBorder(),
      contentPadding: EdgeInsets.symmetric(
          vertical: 0.0, horizontal: 17.0), // Set padding for text
    );
  }

  TextStyle _getLabelStyle() {
    return TextStyle(
      color: _isTextColorChange || !_isInputEmpty
          ? Colors.orange
          : Color(0xFFA3A9AC),
      fontWeight: FontWeight.w500,
      fontSize: widget.fontSize,
      letterSpacing: 1.0,
    );
  }

  OutlineInputBorder _getFocusedInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: Color(0xFFFFBD3F), width: 2.2),
    );
  }

  OutlineInputBorder _getEnabledInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13.0),
      borderSide: _isInputEmpty
          ? BorderSide(color: Color(0xFFD2D9DD), width: 2.2)
          : BorderSide(color: Color(0xFFFFBD3F), width: 2.2),
    );
  }

  void _handleTap() {
    setState(() {
      _isTextColorChange = true;
    });
  }

  void _handleTextChange(String value) {
    setState(() {
      _isInputEmpty = value.isEmpty;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}