import 'package:ensure_visible_when_focused/ensure_visible_when_focused.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/widgets/custom_button_01.dart';
import 'package:rongchoi_app/app/widgets/custom_button_02.dart';
import 'package:rongchoi_app/app/widgets/custom_circle_image.dart';
import 'package:rongchoi_app/app/widgets/custom_clickable_text.dart';
import 'package:rongchoi_app/app/widgets/custom_svg_picture.dart';
import 'package:rongchoi_app/app/widgets/custom_text.dart';
import 'package:rongchoi_app/app/widgets/custom_textfield.dart';
import 'package:rongchoi_app/app/widgets/page_widget/page_login_widgets.dart';
import 'package:rongchoi_app/app/widgets/screen_config.dart';
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

  late final double screenWidth = ScreenSize.screenWidth;
  late final double screenHeight = ScreenSize.screenHeight;

  final FocusNode _emailFocus;
  final FocusNode _passFocus;

  LoginPageView()
      : _emailFocus = FocusNode(),
        _passFocus = FocusNode(),
        super(LoginController(DataAuthenticationRepository()));

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
    ScreenConfig.init(screenWidth, screenHeight);

    return Scaffold(
        body: ModalProgressHUD(
            inAsyncCall: _isLoading, child: _buildLoginFormWidget()));
  }

  Widget _buildLoginFormWidget() {
    final _formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Container(
      width: screenWidth, // Set width to match screen width
      height: screenHeight, // Set height to match screen height
      alignment: Alignment.center, // Align the content to center
      child: Stack(
        children: [
          decorLeft01,
          decorBottomLeft04,
          Column(
            children: [
              decorRight03,
              decorRight02,
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
                    logoRongChoi,
                    loginText,
                    const SizedBox(height: 30),
                    /*
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: UsernameTextField(
                        text: app.usernameLabel,
                        controller: _email,
                      ),
                    ),
                    */
                    emailField,
                    const SizedBox(height: 18),
                    /*

                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: PasswordTextField(
                        text: app.passwordLabel,
                        controller: _password,
                      ),
                    ),
                    */
                    passwordField,
                    const SizedBox(height: 17),

                    /*
                    clean_architecture.ControlledWidgetBuilder<LoginController>(
                      builder: (context, controller) {
                        return ForgotPasswordText(
                          text: app.forgotPasswordLabel,
                          onTap: () => controller.login(),
                        );
                      },
                    ),
                    */
                    const SizedBox(height: 17),
                    /*
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
                     */
                    loginButton,
                    const SizedBox(height: 16),
                    /*
                    clean_architecture.ControlledWidgetBuilder<LoginController>(
                      builder: (context, controller) {
                        return RegisterButton(
                          text: app.registerButtonLabel,
                          onTap: () => controller.login(),
                        );
                      },
                    ),
                    */
                    registerButton,
                    SizedBox(height: (screenHeight / 55)),
                    orText,
                    SizedBox(height: (screenHeight / 80)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*

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
                        */

                        googleButton,
                        SizedBox(
                          width: screenWidth / 10,
                        ),

                        /*

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
                        */
                        facebookButton
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

  Widget get logoRongChoi => Positioned(
      child: Container(
          margin: const EdgeInsets.all(20.0),
          child: CustomSvgPicture(
              width: screenWidth / 3,
              height: screenHeight / 3,
              url: 'assets/svg/logo-rongchoi-01.svg')));

  Widget get decorLeft01 => Positioned(
          child: Align(
        alignment: Alignment.topLeft,
        child: Container(
            child: CustomSvgPicture(
                width: screenWidth / 5,
                height: screenHeight / 5,
                url: 'assets/svg/login-decore-01.svg')),
      ));

  Widget get decorRight02 => Positioned(
          child: Align(
        alignment: Alignment.topRight,
        child: CustomSvgPicture(
            width: screenWidth / 6,
            height: screenHeight / 6,
            url: 'assets/svg/login-decore-02.svg'),
      ));

  Widget get decorRight03 => Positioned(
          child: Align(
        alignment: Alignment.topRight,
        child: CustomSvgPicture(
            width: screenWidth / 4,
            height: screenHeight / 4,
            url: 'assets/svg/login-decore-03.svg'),
      ));

  Widget get decorBottomLeft04 => Positioned(
        bottom: 0, // Đặt bottom thành 0 để nằm ở phía dưới cùng của màn hình
        left: 0, // Đặt left thành 0 để nằm ở bên trái của màn hình
        child: CustomSvgPicture(
          width: screenWidth / 5.4,
          height: screenHeight / 5.4,
          url: 'assets/svg/login-decore-04.svg',
        ),
      );

  Widget get forgotPasswordText => GestureDetector(
        onTap: () => {},
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Align(
            alignment: Alignment.centerRight,
            child: CustomClickableText(
                text: AppLocalizations.of(context)!.forgotPasswordLabel),
          ),
        ),
      );

  Widget get orText => GestureDetector(
      onTap: () => {},
      child: CustomText(
        text: AppLocalizations.of(context)!.orLabel,
        fontSize: ScreenConfig.sizeOrLabel,
      ));

  Widget get loginText => GestureDetector(
        onTap: () => {},
        child: CustomText(
          text: AppLocalizations.of(context)!.loginTitle,
          fontSize: ScreenConfig.sizeLoginTitle,
        ),
      );

  Widget get googleButton => GestureDetector(
      onTap: () => {},
      child: CustomCircleImage(
        widthPicture: screenWidth / 10 * 0.8,
        heightPicture: screenHeight / 10 * 0.8,
        color: Colors.white,
        url: 'assets/svg/icon-google.svg',
      ));

  Widget get facebookButton => GestureDetector(
      onTap: () => {},
      child: CustomCircleImage(
        widthPicture: screenWidth / 10 * 0.9,
        heightPicture: screenHeight / 10 * 0.9,
        color: Colors.transparent,
        url: 'assets/svg/icon-facebook.svg',
      ));

  Widget get loginButton => Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: GestureDetector(
            onTap: () => {},
            child: CustomButton_01(
              text: AppLocalizations.of(context)!.loginButtonLabel,
            )),
      );

  Widget get registerButton => Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: GestureDetector(
            onTap: () => {},
            child: CustomButton_02(
                text: AppLocalizations.of(context)!.registerButtonLabel)),
      );

  Widget get emailField => EnsureVisibleWhenFocused(
      focusNode: _emailFocus,
      child: CustomTextField(
        text: AppLocalizations.of(context)!.usernameLabel,
        fontSize: ScreenConfig.sizeUsernameLabel,
        controller: _email,
      ));

  Widget get passwordField => EnsureVisibleWhenFocused(
      focusNode: _passFocus,
      child: CustomTextField(
        text: AppLocalizations.of(context)!.passwordLabel,
        fontSize: ScreenConfig.sizeUsernameLabel,
        controller: _password,
      ));
}
