import 'package:ensure_visible_when_focused/ensure_visible_when_focused.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/presentation/bloc/language_bloc.dart';
import 'package:rongchoi_app/app/presentation/bloc/language_event.dart';
import 'package:rongchoi_app/app/page/home/home_controller.dart';
import 'package:rongchoi_app/app/page/login/login_controller.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/widgets/button_eye.dart';
import 'package:rongchoi_app/app/widgets/custom_button_01.dart';
import 'package:rongchoi_app/app/widgets/custom_button_02.dart';
import 'package:rongchoi_app/app/widgets/custom_circle_image.dart';
import 'package:rongchoi_app/app/widgets/custom_clickable_text.dart';
import 'package:rongchoi_app/app/widgets/custom_image.dart';
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
import 'package:rongchoi_app/main.dart';

class LoginPage extends clean_architecture.View {
  const LoginPage({
    Key? key,
    required this.title,
    required this.bloc,
  }) : super(key: key);

  final String title;

  final bloc;

  @override
  // ignore: no_logic_in_create_state
  LoginPageResponsiveViewState createState() => LoginPageResponsiveViewState();
}

class LoginPageResponsiveViewState
    extends clean_architecture.ResponsiveViewState<LoginPage, LoginController> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocus;
  final FocusNode _passFocus;

  LoginPageResponsiveViewState()
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
    return Scaffold(
      key: globalKey,
      body: child, // Provide a default value for child
    );
  }

  @override
  Widget get mobileView => loginScaffold(child:
          clean_architecture.ControlledWidgetBuilder<LoginController>(
              builder: (context, controller) {
        return ModalProgressHUD(
            inAsyncCall: controller.isLoading, child: _buildLoginFormWidget());
      }));

  Widget _buildLoginFormWidget() {
    return SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Container(
      width: ScreenSize.screenWidth, // Set width to match screen width
      height: ScreenSize.screenHeight, // Set height to match screen height
      alignment: Alignment.center, //
      child: Stack(
        children: <Widget>[
          background,
          decorLeft01,
          decorBottomLeft04,
          Column(
            children: <Widget>[
              decorRight03,
              decorRight02,
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              logoRongChoi,
                              loginText,
                              const SizedBox(height: 30),
                              emailField,
                              const SizedBox(height: 18),
                              passwordField,
                              const SizedBox(height: 17),
                              forgotPasswordButton,
                              const SizedBox(height: 17),
                              loginButton,
                              const SizedBox(height: 16),
                              SizedBox(height: (ScreenSize.screenWidth / 35)),
                              orText,
                              SizedBox(height: (ScreenSize.screenHeight / 85)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  googleButton,
                                  SizedBox(
                                    width: ScreenSize.screenWidth / 10,
                                  ),
                                  facebookButton,
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  haveAccountRichText,
                  changeLanguageButton
                ],
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

  @override
  // TODO: implement desktopView
  Widget get desktopView => throw UnimplementedError();

  Widget get background => Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        width: ScreenSize.screenWidth,
        height: ScreenSize.screenHeight,
        color: Colors.white,
      ));

  // Logo
  Widget get logoRongChoi => Container(
        margin: const EdgeInsets.all(20.0),
        child: CustomSvgPicture(
          width: ScreenSize.screenWidth / 3,
          height: ScreenSize.screenHeight / 3,
          url: 'assets/svg/logo-rongchoi-01.svg',
        ),
      );

  // Decor 01
  Widget get decorLeft01 => Positioned(
        child: Align(
          alignment: Alignment.topLeft,
          child: CustomSvgPicture(
              width: ScreenSize.screenWidth / 5,
              height: ScreenSize.screenHeight / 5,
              url: Resources.loginDecor01Url),
        ),
      );

  // Decor 02
  Widget get decorRight02 => Align(
        alignment: Alignment.topRight,
        child: CustomSvgPicture(
            width: ScreenSize.screenWidth / 6,
            height: ScreenSize.screenHeight / 6,
            url: Resources.loginDecor02Url),
      );

  // Decor 03
  Widget get decorRight03 => Align(
        alignment: Alignment.topRight,
        child: CustomSvgPicture(
            width: ScreenSize.screenWidth / 4,
            height: ScreenSize.screenHeight / 4,
            url: Resources.loginDecor03Url),
      );

  // Decor 04
  Widget get decorBottomLeft04 => Positioned(
        bottom: 0, // Đặt bottom thành 0 để nằm ở phía dưới cùng của màn hình
        left: 0, // Đặt left thành 0 để nằm ở bên trái của màn hình
        child: CustomSvgPicture(
          width: ScreenSize.screenWidth / 5.4,
          height: ScreenSize.screenHeight / 5.4,
          url: Resources.loginDecor04Url,
        ),
      );

  // LoginButton
  Widget get loginButton =>
      clean_architecture.ControlledWidgetBuilder<LoginController>(
          builder: (context, controller) {
        final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return CustomButton_01(
            onTap: () => controller.login(),
            text: appLocalization.loginButtonLabel,
          );
        } else {
          return Container();
        }
      });

  // ForgotPassword
  Widget get forgotPasswordButton =>
      clean_architecture.ControlledWidgetBuilder<LoginController>(
          builder: (context, controller) {
        final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return GestureDetector(
            onTap: () => {},
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Align(
                alignment: Alignment.centerRight,
                child: CustomClickableText(
                  text: appLocalization.forgotPasswordLabel,
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      });

  // Or Text
  Container get orText {
    final appLocalization = AppLocalizations.of(context);
    if (appLocalization != null) {
      return Container(
        child: CustomText(
          text: appLocalization.orLabel,
          fontSize: ScreenConfig.sizeOrLabel,
        ),
      );
    } else {
      return Container();
    }
  }

  //Login Text
  Container get loginText {
    final appLocalization = AppLocalizations.of(context);
    if (appLocalization != null) {
      return Container(
        child: CustomText(
          text: appLocalization.loginTitle,
          fontSize: ScreenConfig.sizeLoginTitle,
        ),
      );
    } else {
      return Container();
    }
  }

  // Facebook Button
  Widget get facebookButton =>
      clean_architecture.ControlledWidgetBuilder<LoginController>(
          builder: (context, controller) {
        final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return GestureDetector(
              // Login via facebook account
              onTap: () => {},
              child: CustomCircleImage(
                widthPicture: ScreenSize.screenWidth / 10 * 0.9,
                heightPicture: ScreenSize.screenHeight / 10 * 0.9,
                color: Colors.transparent,
                url: 'assets/svg/icon-facebook.svg',
              ));
        } else {
          return Container();
        }
      });

  // Google Button
  Widget get googleButton =>
      clean_architecture.ControlledWidgetBuilder<LoginController>(
          builder: (context, controller) {
        final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return GestureDetector(
            // Login via Google account
            onTap: () => controller.loginWithGoogle(),
            child: CustomCircleImage(
              widthPicture: ScreenSize.screenWidth / 10 * 0.8,
              heightPicture: ScreenSize.screenHeight / 10 * 0.8,
              color: Colors.white,
              url: 'assets/svg/icon-google.svg',
            ),
          );
        } else {
          return Container(child: Text("Error button"));
        }
      });

  // Register Button
  Widget get registerButton =>
      clean_architecture.ControlledWidgetBuilder<LoginController>(
          builder: (context, controller) {
        final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return CustomButton_02(
            // Register account
            onTap: () => controller.register(),
            text: appLocalization.registerButtonLabel,
          );
        } else {
          return Container();
        }
      });

  // Email Field
  Widget get emailField =>
      clean_architecture.ControlledWidgetBuilder<LoginController>(
          builder: (context, controller) {
        final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return EnsureVisibleWhenFocused(
              focusNode: _emailFocus,
              child: CustomTextField(
                TextHint: appLocalization.usernameLabel,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: false,
              )

              /* CustomTextField(
              text: appLocalization.usernameLabel,
              fontSize: ScreenConfig.sizeUsernameLabel,
              controller: controller.emailTextController,
            ),
            */
              );
        } else {
          return Container();
        }
      });

  // Password Field
  Widget get passwordField =>
      clean_architecture.ControlledWidgetBuilder<LoginController>(
          builder: (context, controller) {
        final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return EnsureVisibleWhenFocused(
              focusNode: _passFocus,
              child: Stack(
                children: [
                  CustomTextField(
                    TextHint: appLocalization.passwordLabel,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: false,
                  ),
                  Positioned(right: 3.0, child: ButtonEye())
                ],
              )

              /* CustomTextField(
              text: appLocalization.usernameLabel,
              fontSize: ScreenConfig.sizeUsernameLabel,
              controller: controller.emailTextController,
            ),
            */
              );
        } else {
          return Container();
        }
      });

  // Register RichText

  Widget get haveAccountRichText =>
      clean_architecture.ControlledWidgetBuilder<LoginController>(
          builder: (context, controller) {
        final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
                text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: TextStyle(
                      color: const Color(0xFFA3A9AC),
                      fontSize: ScreenConfig.loginHaveAccountLabel,
                      fontWeight: FontWeight.w500),
                  text: appLocalization.loginHaveAccountLabel,
                ),
                TextSpan(
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: ScreenConfig.loginRegisterClickText,
                      fontWeight: FontWeight.w600,
                    ),
                    text: appLocalization.loginRegisterClickText,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Register clicked');
                      }),
              ],
            )),
          );
        } else {
          return const Text("Error HaveAccountRichText");
        }
      });

  Widget get changeLanguageButton =>
      clean_architecture.ControlledWidgetBuilder<LoginController>(
          builder: (context, controller) {
        final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () => MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: 'en')),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(appLocalization.loginLanguageLabel),
                  const SizedBox(width: 8.0,),
                  const CustomSvgPicture(
                    url: 'assets/svg/icon-language/icon-american.svg',
                    width: 29,
                    height: 29,
                  )
                ],
              ),
            ),
          );
        } else {
          return const Text("Error changeLanguageButton");
        }
      });
}
