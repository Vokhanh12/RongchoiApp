import 'package:ensure_visible_when_focused/ensure_visible_when_focused.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:rongchoi_app/app/page/confirm%20registration/confirm_registration_controller.dart';
import 'package:rongchoi_app/app/page/splash/splash_controller.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/app/widgets/custom_button_01.dart';
import 'package:rongchoi_app/app/widgets/custom_image.dart';
import 'package:rongchoi_app/app/widgets/custom_svg_picture.dart';
import 'package:rongchoi_app/app/widgets/custom_textfield.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/data/repositories/data_navigation_repository.dart';
import 'package:rongchoi_app/device/repositories/device_location_repository.dart';
import 'package:rongchoi_app/shared/build_config/config_font_size.dart';
import 'package:rongchoi_app/shared/build_config/screen_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmRegistrationPage extends clean_architecture.View {
  const ConfirmRegistrationPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  ConfirmRegistrationPageResponsiveViewState createState() =>
      ConfirmRegistrationPageResponsiveViewState();
}

class ConfirmRegistrationPageResponsiveViewState
    extends clean_architecture.ResponsiveViewState<ConfirmRegistrationPage,
        ConfirmRegistrationController> {
  ConfirmRegistrationPageResponsiveViewState()
      : super(ConfirmRegistrationController(
          DataAuthenticationRepository(),
          DataNavigationRepository(),
        ));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget confirmRegistrationScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child, // Provide a default value for child
    );
  }

  Widget _buildRegisterFormWidget() {
    return clean_architecture.ControlledWidgetBuilder<
        ConfirmRegistrationController>(builder: (context, controller) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, top: 25.0, right: 0.0, bottom: 0.0),
              child: iconBackButton,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              child: Column(
                children: [
                  mailAnimation,
                  Flexible(
                    flex: 1,
                    child: notiSentRichText,
                  ),
                  SizedBox(height: 5.0,),
                  Flexible(
                    flex: 1,
                    child: Center(child: tfContainNumPhone),
                  ),
                  Flexible(
                    flex: 3,
                    child: Center(child: inputSMSBox),
                  ),
                ],
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: notGotcodeRichText)
        ],
      );
    });
  }

  @override
  // TODO: implement mobileView
  Widget get mobileView =>
      clean_architecture.ControlledWidgetBuilder<ConfirmRegistrationController>(
          builder: (context, controller) {
        return ModalProgressHUD(
            inAsyncCall: controller.isLoading,
            child: confirmRegistrationScaffold(
              child: _buildRegisterFormWidget(),
            ));
      });

  @override
  // TODO: implement desktopView
  Widget get desktopView => throw UnimplementedError();

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

  Widget get mailAnimation => Lottie.asset(
        "assets/animation/mail.json",
        fit: BoxFit.contain,
        width: 260,
        height: 260,
        repeat: true,
      );

  Widget get iconBackButton {
    return clean_architecture.ControlledWidgetBuilder<
        ConfirmRegistrationController>(
      builder: (context, controller) {
        return IconButton(
            iconSize: 30.0,
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: const FaIcon(FontAwesomeIcons.angleLeft),
            onPressed: () {
              Log.d("iconBackButton pressed", runtimeType);
            });
      },
    );
  }

  Widget get notiSentRichText {
    final appLocalization = AppLocalizations.of(context);
    if (appLocalization != null) {
      return Container(
        child: RichText(
            text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              style: TextStyle(
                  color: const Color(0xFFA3A9AC),
                  fontSize: ConfigFontSize.sizeConfirmRegisNoSentLabel,
                  fontWeight: FontWeight.w500),
              text: appLocalization.confirmRegisNoSentLabel,
            ),
          ],
        )),
      );
    } else {
      return const Text("Error notiSentRichText");
    }
  }

  Widget get tfContainNumPhone {
    return clean_architecture.ControlledWidgetBuilder<
        ConfirmRegistrationController>(builder: (context, controller) {
      final appLocalization = AppLocalizations.of(context);
      if (appLocalization != null) {
        return Container(
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 3.5, color: Color(0xFFD2D9DD)),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            "0965558473",
            style: TextStyle(
                color: Color(0xFF727070),
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 12.0),
          ),
        );
      } else {
        return Container();
      }
    });
  }

  Widget get inputSMSBox {
    final defaultPinTheme = PinTheme(
      width: 65,
      height: 65,
        constraints: const BoxConstraints(
          maxWidth: 65,
            maxHeight: 65, // Set the maximum height
          ),
      textStyle: const TextStyle(
          fontSize: 28,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(width: 2.5, color:const  Color(0xFFD2D9DD)),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(width: 3.0, color:const Color(0xFFFF8C00)),
      borderRadius: BorderRadius.circular(8),
    );

    return Container(
      child: Pinput(
        length: 4,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        onCompleted: (pin) => debugPrint(pin),
      ),
    );
  }

  Widget get notGotcodeRichText =>
      clean_architecture.ControlledWidgetBuilder<ConfirmRegistrationController>(
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
                      fontSize: ConfigFontSize.sizeNotGotCodeLabel,
                      fontWeight: FontWeight.w500),
                  text: appLocalization.notGotCodeLabel,
                ),
                TextSpan(
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: ConfigFontSize.sizeResendCode,
                      fontWeight: FontWeight.w600,
                    ),
                    text: appLocalization.resendCode,
                    recognizer: TapGestureRecognizer()..onTap = () {}),
              ],
            )),
          );
        } else {
          return const Text("Error  notGotcodeRichText");
        }
      });

  /*

    // LoginButton
  Widget get confirmButton =>
      clean_architecture.ControlledWidgetBuilder<ConfirmRegistrationController>(
          builder: (context, controller) {
        final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return CustomButton_01(
            onTap: () => (),
            text: "Xác nhận",
          );
        } else {
          return Container();
        }
      });

  Widget get notGotcodeRichText {}
  */
}
