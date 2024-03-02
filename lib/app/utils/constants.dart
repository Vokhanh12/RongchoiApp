import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:rongchoi_app/domain/entities/language.dart';

class Resources {
  static const String background = 'none';
  static const String logo = 'assets/svg/logo-rongchoi-01.svg';
  static const String logoNotTitile = 'assets/svg/logo-not-titile.svg';
  static const String loginDecor01Url = 'assets/svg/login-decore-01.svg';
  static const String loginDecor02Url = 'assets/svg/login-decore-02.svg';
  static const String loginDecor03Url = 'assets/svg/login-decore-03.svg';
  static const String loginDecor04Url = 'assets/svg/login-decore-04.svg';

  static const String loginIconCurrentLanguageUrl =
      '/home/vokhanh/development/flutter/RongChoi_Project/rongchoi_app/assets/svg/icon-language/icon-vietnam.svg';

  static const String loader = 'assets/img/loading.svg';
  static const String event_race = 'assets/img/event_race.jpg';
  static const String event_spaghetti = 'assets/img/event_spaghetti.jpg';
  static const String event_consumer = 'assets/img/event_consumer.jpg';
  static const String checkpoint = 'assets/img/checkpoint_16x16.bmp';

  static const List<Map<String, String>> languages = [
    {
      'name': 'Vietnamese',
      'code': 'vi',
      'iconUrl': 'assets/svg/icon-language/icon-vietnam.svg'
    },
    {
      'name': 'English(US)',
      'code': 'en',
      'iconUrl': 'assets/svg/icon-language/icon-american.svg'
    },
    {
      'name': 'Japan',
      'code': 'ja',
      'iconUrl': 'assets/svg/icon-language/icon-japan.svg'
    },
    {
      'name': 'France',
      'code': 'fr',
      'iconUrl': 'assets/svg/icon-language/icon-france.svg'
    },
    {
      'name': 'German',
      'code': 'de',
      'iconUrl': 'assets/svg/icon-language/icon-germany.svg'
    },
    {
      'name': 'United Kingdom',
      'code': 'en-GB',
      'iconUrl': 'assets/svg/icon-language/icon-american.svg'
    },
  ];
}


class Routes{
  
  static const root = '/';
  static const loginNamePage = '/login';
  static const registerNamePage = '/register';
  static const homeNamePage = '/home';
  static const languageNamePage = '/language';

  /*
  static const homeNamedPage = '/home';
  static const homeDetailsNamedPage = 'details';
  static const profileNamedPage = '/profile';
  static const profileDetailsNamedPage = 'details';
  static const settingsNamedPage = '/settings';
  //static profileNamedPage([String? name]) => '/${name ?? ':profile'}';
  static Widget errorWidget(BuildContext context, GoRouterState state) => const NotFoundScreen();
  */

}


/// Returns the app's default snackbar with a [text].
SnackBar _getGenericSnackbar(String text, bool isError) {
  return SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: Wrap(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 25.0, vertical: 12.0), // Điều chỉnh padding
              decoration: BoxDecoration(
                color: Colors.white, // Sử dụng màu xám nhạt cho background
                borderRadius: BorderRadius.circular(
                    30.0), // Bo tròn góc với giá trị nhỏ hơn
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF808080), // Điều chỉnh màu chữ
                  fontSize: 15.0, // Giảm kích thước chữ để phù hợp với SnackBar
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    duration: const Duration(seconds: 2), // Tăng thời gian hiển thị lên 3 giây
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(8.0), // Điều chỉnh bo tròn góc của SnackBar
    ),
  );
}

/// Shows a generic [Snackbar]
void showGenericSnackbar(BuildContext context, String text,
    {bool isError = false}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(_getGenericSnackbar(text, isError));
}

class Languages {
  const Languages._();

  static const languages = [
    Language(code: 'vi', value: 'Vietnamese'),
    Language(code: 'en', value: 'English'),
  ];
}
