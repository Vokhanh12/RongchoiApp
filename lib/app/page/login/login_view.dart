import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/page/widgets/button.dart';
import 'package:rongchoi_app/app/page/widgets/textfield.dart';
import 'package:rongchoi_app/domain/interface/screen_size_provider.dart';

class LoginPage extends clean_architecture.View {
  const LoginPage(
      {Key? key, required this.title, required this.screenSizeProviderInstance})
      : super(key: key);

  final String title;
  final ScreenSizeProvider screenSizeProviderInstance;

  @override
  LoginPageState createState() =>
      // inject dependencies inwards
      LoginPageState(screenSizeProviderInstance);
}

class LoginPageState
    extends clean_architecture.ViewState<LoginPage, LoginController> {
  final ScreenSizeProvider screenSizeProvider;

  LoginPageState(this.screenSizeProvider) : super(LoginController());

  @override
  Widget get view {
    double screenWidth = screenSizeProvider.getScreenWidth(context);
    double screenHeight = screenSizeProvider.getScreenHeight(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scaffold(
          key:
              globalKey, // built in global key for the ViewState for easy access in the controller
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginTextField(text: 'Tên tài khoản'),
                  SizedBox(height: 13),
                  LoginTextField(text: 'Mật khẩu'),
                ],
              ),
            ),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
