import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/widgets/page_widget/page_login_widgets.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/domain/interface/screen_size_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';

class LoginPage extends clean_architecture.View {
  const LoginPage({
    Key? key,
    required this.title,
    required this.screenSizeProviderInstance,
  }) : super(key: key);

  final String title;
  final ScreenSizeProvider screenSizeProviderInstance;

  @override
  // ignore: no_logic_in_create_state
  LoginPageState createState() => LoginPageState(screenSizeProviderInstance);
}

class LoginPageState
    extends clean_architecture.ResponsiveViewState<LoginPage, LoginController> {
  final ScreenSizeProvider screenSizeProvider;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPageState(this.screenSizeProvider)
      : super(LoginController(
            email: '',
            password: '',
            authenticationRepo: DataAuthenticationRepository()));

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
  Widget get mobileView {
    double screenWidth = screenSizeProvider.getScreenWidth(context);
    double screenHeight = screenSizeProvider.getScreenHeight(context);

    AppLocalizations app = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Container(
          width: screenWidth, // Set width to match screen width
          height: screenHeight, // Set height to match screen height
          alignment: Alignment.center, // Align the content to center
          child: Stack(
            children: [
              DecorLeft01(
                width: screenWidth,
                height: screenHeight,
              ),
              DecorBottomLeft04(
                width: screenWidth,
                height: screenHeight,
              ),
              Column(
                children: [
                  DecorRight03(
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
                      clean_architecture.ControlledWidgetBuilder<
                          LoginController>(
                        builder: (context, controller) {
                          return ForgotPasswordText(
                            text: app.forgotPasswordLabel,
                            onTap: () => controller.login(),
                          );
                        },
                      ),
                      const SizedBox(height: 17),
                      clean_architecture.ControlledWidgetBuilder<
                          LoginController>(
                        builder: (context, controller) {
                          return LoginButton(
                            text: app.loginButtonLabel,
                            onTap: () => controller.login(),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      clean_architecture.ControlledWidgetBuilder<
                          LoginController>(
                        builder: (context, controller) {
                          return RegisterButton(
                            text: app.registerButtonLabel,
                            onTap: () => controller.login(),
                          );
                        },
                      ),
                      SizedBox(height: (screenHeight/55)),
                      OrText(text: app.orLabel),
                          SizedBox(height: (screenHeight/80)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          clean_architecture.ControlledWidgetBuilder<
                              LoginController>(
                            builder: (context, controller) {
                              return CircleGoogle(
                                width: screenWidth,
                                height: screenHeight,
                                onTap: () => controller.login(),
                              );
                            },
                          ),
                          SizedBox(
                            width: screenWidth / 10,
                          ),
                          clean_architecture.ControlledWidgetBuilder<
                              LoginController>(
                            builder: (context, controller) {
                              return CircleFacebook(
                                width: screenWidth,
                                height: screenHeight,
                                onTap: () => controller.login(),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
