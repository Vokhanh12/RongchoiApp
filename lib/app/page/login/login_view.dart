import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/widgets/page_widget/page_login_widgets.dart';
import 'package:rongchoi_app/app/widgets/screen_size.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/firebase_options.dart';

class LoginPage extends clean_architecture.View {
  const LoginPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  // ignore: no_logic_in_create_state
  LoginPageView createState() => LoginPageView();
}

class LoginPageView
    extends clean_architecture.ResponsiveViewState<LoginPage, LoginController> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  bool _isLoading = false;

  LoginPageView() : super(LoginController(DataAuthenticationRepository()));

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget loginScaffold({Widget? child}) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        key: globalKey,
        body: child, // Provide a default value for child
      ),
    );
  }

  void _submit() {
    setState(() {
      _isLoading = true;
    });

    print("Submitting to backend ...");

    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  // TODO: implement desktopView
  Widget get desktopView => Container();

  @override
  Widget get mobileView {
    ScreenSize.init(context);

    return Scaffold(
        body: ModalProgressHUD(
            inAsyncCall: _isLoading, child: _buildLoginFormWidget()));
  }

  Widget _buildLoginFormWidget() {
    final _formKey = GlobalKey<FormState>();

    AppLocalizations app = AppLocalizations.of(context)!;

    final double screenWidth = ScreenSize.screenWidth;
    final double screenHeight = ScreenSize.screenHeight;

    return SingleChildScrollView(
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
              child: Form(
                key: _formKey,
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
                        controller: _email,
                      ),
                    ),
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: PasswordTextField(
                        text: app.passwordLabel,
                        controller: _password,
                      ),
                    ),
                    const SizedBox(height: 17),
                    clean_architecture.ControlledWidgetBuilder<LoginController>(
                      builder: (context, controller) {
                        return ForgotPasswordText(
                          text: app.forgotPasswordLabel,
                          onTap: () => controller.login(),
                        );
                      },
                    ),
                    const SizedBox(height: 17),
                    clean_architecture.ControlledWidgetBuilder<LoginController>(
                      builder: (context, controller) {
                        return LoginButton(
                          text: app.loginButtonLabel,
                          onTap: () {
                            controller.login();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    clean_architecture.ControlledWidgetBuilder<LoginController>(
                      builder: (context, controller) {
                        return RegisterButton(
                          text: app.registerButtonLabel,
                          onTap: () => controller.login(),
                        );
                      },
                    ),
                    SizedBox(height: (screenHeight / 55)),
                    OrText(text: app.orLabel),
                    SizedBox(height: (screenHeight / 80)),
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
                              onTap: _submit,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  // TODO: implement tabletView
  Widget get tabletView => Container();

  @override
  // TODO: implement watchView
  Widget get watchView => Container();
}
