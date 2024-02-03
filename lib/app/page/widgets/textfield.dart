import 'package:rongchoi_app/app/page/home/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';

class LoginTextField extends StatefulWidget {
  final String text;

  const LoginTextField({Key? key, required this.text}) : super(key: key);

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}
class _LoginTextFieldState extends State<LoginTextField> {
  bool _isTextColorChange = false;
  bool _isInputEmpty = true;
  FocusNode _focusNode = FocusNode();
  late TextEditingController _textEditingController;

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

    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    constraints: BoxConstraints(
      maxHeight: 80, // Set the maximum height
    ),

      child: TextField(
        controller: _textEditingController,
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
    );
  }

  TextStyle _getLabelStyle() {
    return TextStyle(
      color: _isTextColorChange || !_isInputEmpty
          ? Colors.orange
          : Color(0xFFA3A9AC),
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      letterSpacing: 1.0,
    );
  }

  OutlineInputBorder _getFocusedInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: Color(0xFFFFBD3F), width: 3.0),
    );
  }

  OutlineInputBorder _getEnabledInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13.0),
      borderSide: _isInputEmpty
          ? BorderSide(color: Color(0xFFD2D9DD), width: 3.0)
          : BorderSide(color: Color(0xFFFFBD3F), width: 3.0),
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
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
