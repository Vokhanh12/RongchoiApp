import 'package:rongchoi_app/app/page/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/widgets/custom_button_01.dart';
import 'package:rongchoi_app/app/widgets/custom_button_02.dart';
import 'package:rongchoi_app/app/widgets/custom_circle_image.dart';
import 'package:rongchoi_app/app/widgets/custom_clickable_text.dart';

import 'package:rongchoi_app/app/widgets/custom_svg_picture.dart';
import 'package:rongchoi_app/app/widgets/custom_text.dart';
import 'package:rongchoi_app/app/widgets/custom_textfield.dart';

// TextField

class UsernameTextField extends StatelessWidget {
  final String text;

  const UsernameTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        constraints: const BoxConstraints(maxWidth: 600),
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
        constraints: const BoxConstraints(maxWidth: 600),
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
      constraints: const BoxConstraints(maxWidth: 600),
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
      constraints: const BoxConstraints(maxWidth: 600),
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
      constraints: const BoxConstraints(maxWidth: 600),
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
  final double width;
  final double height;

  const CircleGoogle({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return CustomCircleImage(
      width: width / 10,
      height: height / 10,
      url: 'assets/svg/icon-google.svg',
      onTap: () => {print("Google clicked")},
    );
  }
}

class CircleFacebook extends StatelessWidget {
  final double width;
  final double height;

  const CircleFacebook({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return CustomCircleImage(
      width: width / 10,
      height: height / 10,
      url: 'assets/svg/icon-facebook.svg',
      onTap: () => {print("Facebook clicked")},
    );
  }
}

class LogoRongchoi extends StatelessWidget {
  final double width;
  final double height;

  const LogoRongchoi({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20.0),
        child: CustomSvgPicture(
            width: this.width / 3,
            height: this.height / 3,
            url: 'assets/svg/logo-rongchoi-01.svg'));
  }
}

class DecorLeft extends StatelessWidget {
  final double width;
  final double height;
  const DecorLeft({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext contex) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
          child: CustomSvgPicture(
              width: this.width / 5,
              height: this.height / 5,
              url: 'assets/svg/login-decore-01.svg')),
    );
  }
}

class DecorRight01 extends StatelessWidget {
  final double width;
  final double height;
  const DecorRight01({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: CustomSvgPicture(
          width: this.width / 4,
          height: this.height / 4,
          url: 'assets/svg/login-decore-03.svg'),
    );
  }
}

class DecorRight02 extends StatelessWidget {
  final double width;
  final double height;
  const DecorRight02({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: CustomSvgPicture(
          width: this.width / 6,
          height: this.height / 6,
          url: 'assets/svg/login-decore-02.svg'),
    );
  }
}

class DecorBottom extends StatelessWidget {
  final double width;
  final double height;
  const DecorBottom({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}