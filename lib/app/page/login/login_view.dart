import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/page/widgets/button.dart';
import 'package:rongchoi_app/app/page/widgets/page_login_widgets.dart';
import 'package:rongchoi_app/domain/interface/screen_size_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    AppLocalizations app = AppLocalizations.of(context)!;

    return Scaffold(
      body: Scaffold(
        key: globalKey,
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      constraints:
                          BoxConstraints(maxHeight: 400, minWidth: 400),
                      margin: const EdgeInsets.all(50.0),
                      child: Image.asset('assets/img/logo-rongchoi.png',
                          fit: BoxFit.contain),
                    ),
                    LoginText(text: app.loginTitle),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: UsernameTextField(
                        text: app.usernameLabel,
                      ),
                    ),
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: PasswordTextField(
                        text: app.passwordLabel,
                      ),
                    ),
                    const SizedBox(height: 17),
                    ForgotPasswordText(text: app.forgotPasswordLabel),
                    const SizedBox(height: 17),
                    LoginButton(text: app.loginButtonLabel),
                    const SizedBox(height: 16),
                    RegisterButton(text: app.registerButtonLabel),
                    const SizedBox(height: 19),
                    OrText(text: app.orLabel),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleGoogle(),
                        SizedBox(
                          width: screenWidth / 10,
                        ),
                        CircleFacebook(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
