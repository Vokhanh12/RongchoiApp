import 'package:rongchoi_app/app/page/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/page/widgets/custom_button.dart';
import 'package:rongchoi_app/app/page/widgets/custom_clickable_text.dart';
import 'package:rongchoi_app/app/page/widgets/custom_textfield.dart';

// TextField

class UsernameTextField extends StatelessWidget {
  final String text;

  const UsernameTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomTextField(text: text);
  }
}

class PasswordTextField extends StatelessWidget {
 final String text;

 const PasswordTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomTextField(text: text);
  }
}

// Button

class LoginButton extends StatelessWidget {
  final String text;

  const LoginButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final controller =
        FlutterCleanArchitecture.getController<LoginController>(context);

    return CustomButton(text: text, onTap: () => {print("Clicked Button Login")});
  }
}


class RegisterButton extends StatelessWidget {
  final String text;

  const RegisterButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final controller =
        FlutterCleanArchitecture.getController<LoginController>(context);

    return CustomButton(text: text, onTap: () => {print("Clicked Button Register")});
  }
}



// ClickableText


class ForgotPasswordText extends StatelessWidget{

  final String text;

  const ForgotPasswordText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {

    final controller =  FlutterCleanArchitecture.getController<LoginController>(context);
    
    return CustomClickableText(text: text,onTap: () => {print("Clicked Text Forget password")});


  }



}
