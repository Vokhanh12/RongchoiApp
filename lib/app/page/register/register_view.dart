import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/page/register/register_controller.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/widgets/custom_button_01.dart';
import 'package:rongchoi_app/app/widgets/custom_circle_image.dart';
import 'package:rongchoi_app/app/widgets/custom_clickable_text.dart';
import 'package:rongchoi_app/app/widgets/custom_svg_picture.dart';
import 'package:rongchoi_app/app/widgets/custom_text.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/shared/build_config/screen_config.dart';
import 'package:rongchoi_app/shared/build_config/screen_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends clean_architecture.View {
  const RegisterPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  // ignore: no_logic_in_create_state
  RegisterPageResponsiveViewState createState() =>
      RegisterPageResponsiveViewState();
}

class RegisterPageResponsiveViewState extends clean_architecture
    .ResponsiveViewState<RegisterPage, RegisterController> {
  RegisterPageResponsiveViewState()
      : super(RegisterController(DataAuthenticationRepository()));

  Widget registerScaffold({Widget? child}) {
    return Scaffold(key: globalKey, body: child);
  }

  Widget _buildRegisterFormWidget() {
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
  // TODO: implement desktopView
  Widget get desktopView => registerScaffold(
        child: clean_architecture.ControlledWidgetBuilder<RegisterController>(
          builder: (context, controller) {
            return ModalProgressHUD(
                inAsyncCall: controller.isLoading,
                child: _buildRegisterFormWidget());
          },
        ),
      );

  @override
  // TODO: implement mobileView
  Widget get mobileView => throw UnimplementedError();

  @override
  // TODO: implement tabletView
  Widget get tabletView => throw UnimplementedError();

  @override
  // TODO: implement watchView
  Widget get watchView => throw UnimplementedError();



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
          width: ScreenSize.screenWidth / 3.3,
          height: ScreenSize.screenHeight / 3.3,
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

  // RegisterButton
  Widget get registerButton =>
      clean_architecture.ControlledWidgetBuilder<RegisterController>(
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


  //Register Text
  Container get registerText {
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

  // Register Button
  Widget get loginButton =>
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

  // FirstName Field
  Widget get firstNameField =>
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
  
   // LastName Field
  Widget get lastNameField =>
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

       // Username Field
  Widget get usernameField =>
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


       // RePassword Field
  Widget get rePasswordField =>
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

       // NumberPhone Field
  Widget get numberPhoneField =>
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

      

      

      

      
      

  
  // Login RichText
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


  // Change Language Button
  Widget get changeLanguageButton =>
      clean_architecture.ControlledWidgetBuilder<LoginController>(
          builder: (context, loginController) {
        final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              // click nav language page
              onTap: () => loginController.changeLanguage(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(appLocalization.loginLanguageLabel),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Selector<LanguageCubit, String>(
                    selector: (context, cubit) => cubit.state.iconUrl,
                    builder: (context, iconUrl, child) {
                      return CustomSvgPicture(
                        // set first icon vi
                        url: iconUrl,
                        width: 29,
                        height: 29,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text("Error changeLanguageButton");
        }
      });
}



}
