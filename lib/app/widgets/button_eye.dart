import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonEye extends StatefulWidget {
  final VoidCallback? onPressed;

  ButtonEye(
      {Key? key,
      this.onPressed})
      : super(key: key);

  @override
  State<ButtonEye> createState() => _ButtonEyeState();
}

class _ButtonEyeState extends State<ButtonEye> {
 bool isChangeToAcitve = false;
 bool ChangeIcon = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: widget.onPressed,
        icon: ChangeIcon
            ? FaIcon(FontAwesomeIcons.eye,
                color: isChangeToAcitve
                    ? Color(0xFF0D7BD4)
                    : Color(0xFFA3A9AC))
            : FaIcon(FontAwesomeIcons.eyeSlash,
                color: isChangeToAcitve
                    ? Color(0xFF0D7BD4)
                    : Color(0xFFA3A9AC)));
  }
}