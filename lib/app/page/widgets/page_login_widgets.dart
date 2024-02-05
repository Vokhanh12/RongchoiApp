import 'package:rongchoi_app/app/page/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/page/widgets/custom_button_01.dart';
import 'package:rongchoi_app/app/page/widgets/custom_button_02.dart';
import 'package:rongchoi_app/app/page/widgets/custom_circle_image.dart';
import 'package:rongchoi_app/app/page/widgets/custom_clickable_text.dart';
import 'package:rongchoi_app/app/page/widgets/custom_text.dart';
import 'package:rongchoi_app/app/page/widgets/custom_textfield.dart';

// TextField

class UsernameTextField extends StatelessWidget {
  final String text;

  const UsernameTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        constraints: BoxConstraints(maxWidth: 600),
        child: CustomTextField(text: text));
  }
}

class PasswordTextField extends StatelessWidget {
  final String text;

  const PasswordTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        constraints: BoxConstraints(maxWidth: 600),
        child: CustomTextField(text: text));
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

    return Container(
      constraints: BoxConstraints(maxWidth: 600),
      child: CustomButton_01(
          text: text, onTap: () => {print("Clicked Button 01 Login")}),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final String text;

  const RegisterButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final controller =
        FlutterCleanArchitecture.getController<LoginController>(context);

    return Container(
      constraints: BoxConstraints(maxWidth: 600),
      child: CustomButton_02(
          text: text, onTap: () => {print("Clicked Button 02 Register")}),
    );
  }
}

// Text

class ForgotPasswordText extends StatelessWidget {
  final String text;

  const ForgotPasswordText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final controller =
        FlutterCleanArchitecture.getController<LoginController>(context);

    return Container(
      constraints: BoxConstraints(maxWidth: 600),
      child: Align(
        alignment: Alignment.centerRight,
        child: CustomClickableText(
            text: text, onTap: () => {print("Clicked Text Forget password")}),
      ),
    );
  }
}

class OrText extends StatelessWidget {
  final String text;
  const OrText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      fontSize: 14,
    );
  }
}

class LoginText extends StatelessWidget {
  final String text;
  const LoginText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomText(text: text, fontSize: 25);
  }
}

// Image Click

class CircleGoogle extends StatelessWidget {
  const CircleGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomCircleImage(url: 'assets/svg/icon-google.svg');
  }
}

class CircleFacebook extends StatelessWidget {
  const CircleFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomCircleImage(url: 'assets/svg/icon-facebook.svg');
  }
}
