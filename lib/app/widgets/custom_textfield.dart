import 'package:rongchoi_app/app/page/home/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';

/*
class CustomTextField extends StatefulWidget {
  final String text;
  final double fontSize;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.controller,
  }) : super(key: key);

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;
  bool _isTextColorChange = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: _buildInputDecoration(),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      labelText: widget.text,
      labelStyle: _getLabelStyle(),
      focusedBorder: _getFocusedInputBorder(),
      enabledBorder: _getEnabledInputBorder(),
      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 17.0),
    );
  }

  TextStyle _getLabelStyle() {
    return TextStyle(
      color: _isTextColorChange ? Colors.orange : Color(0xFFA3A9AC),
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
      borderSide: BorderSide(
        color: _focusNode.hasFocus ? Color(0xFFFFBD3F) : Color(0xFFD2D9DD),
        width: 2.2,
      ),
    );
  }

  void _handleFocusChange() {
    setState(() {
      _isTextColorChange = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

*/

class CustomTextField extends StatefulWidget {
  final String TextHint;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool obscureText;
  final TextEditingController controller;

  CustomTextField({
    Key? key,
    required this.TextHint,
    required this.enableSuggestions,
    required this.autocorrect,
    required this.obscureText,
    required this.controller,
    this.keyboardType = TextInputType.emailAddress,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<CustomTextField> {
  bool _isChangeToActive = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        setState(() {
          _isChangeToActive = true;
        });
        widget.onTap?.call();
      },
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: _isChangeToActive
            ? Color.fromARGB(255, 255, 255, 255)
            : Color.fromARGB(255, 255, 255, 255),
        contentPadding: EdgeInsets.fromLTRB(13, 13, 0, 0),
        labelText: widget.TextHint,
        labelStyle: TextStyle(
          color: _isChangeToActive
              ? Colors.orange.withOpacity(1)
              : Color(0xFFA3A9AC).withOpacity(1),
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: _isChangeToActive ? Colors.orange : Color(0xFFD2D9DD),
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
