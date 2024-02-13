import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/widgets/page_widget/page_login_widgets.dart';
import 'package:rongchoi_app/domain/interface/screen_size_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends clean_architecture.View {
  const LoginPage({
    Key? key,
    required this.title,
    required this.screenSizeProviderInstance,
  }) : super(key: key);

  final String title;
  final ScreenSizeProvider screenSizeProviderInstance;

  @override
  LoginPageState createState() => LoginPageState(screenSizeProviderInstance);
}


class LoginPageState
    extends clean_architecture.ResponsiveViewState<LoginPage, LoginController> {
  final ScreenSizeProvider screenSizeProvider;

  LoginPageState(this.screenSizeProvider) : super(LoginController());

  Widget loginScaffold({Widget? child}) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        key: globalKey,
        body: child, // Provide a default value for child
      ),
    );
  }

  @override
  // TODO: implement desktopView
  Widget get desktopView => Container();

  @override
  // TODO: implement mobileView
  Widget get mobileView {
    double screenWidth = screenSizeProvider.getScreenWidth(context);
    double screenHeight = screenSizeProvider.getScreenHeight(context);

    AppLocalizations app = AppLocalizations.of(context)!;

    return Scaffold(
      body: Scaffold(
        key: globalKey,
        body: Stack(
          children: [
            DecorLeft(
              width: screenWidth,
              height: screenHeight,
            ),
            Column(
              children: [
                DecorRight01(
                  width: screenWidth,
                  height: screenHeight,
                ),
                DecorRight02(
                  width: screenWidth,
                  height: screenHeight,
                ),
              ],
            ),
            Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        LogoRongchoi(
                          width: screenWidth,
                          height: screenHeight,
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
                            CircleGoogle(
                              width: screenWidth,
                              height: screenHeight,
                            ),
                            SizedBox(
                              width: screenWidth / 10,
                            ),
                            CircleFacebook(
                              width: screenWidth,
                              height: screenHeight,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement tabletView
  Widget get tabletView => Container();

  @override
  // TODO: implement watchView
  Widget get watchView => Container();



}
