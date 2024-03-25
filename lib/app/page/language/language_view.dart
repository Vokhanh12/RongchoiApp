import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/language/language_controller.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/app/widgets/custom_svg_picture.dart';
import 'package:rongchoi_app/app/widgets/custom_text.dart';
import 'package:rongchoi_app/app/widgets/language_card.dart';
import 'package:rongchoi_app/data/repositories/data_navigation_repository.dart';
import 'package:rongchoi_app/domain/entities/language.dart';
import 'package:rongchoi_app/shared/build_config/config_font_size.dart';
import 'package:rongchoi_app/shared/build_config/screen_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rongchoi_app/data/repositories/data_setting_repository.dart';
import 'package:rongchoi_app/main.dart';

class LanguagePage extends clean_architecture.View {
  const LanguagePage({super.key});

  @override
  LanguagePageResponsiveViewState createState() =>
      LanguagePageResponsiveViewState();
}

class LanguagePageResponsiveViewState extends clean_architecture
    .ResponsiveViewState<LanguagePage, LanguageController> {
  LanguagePageResponsiveViewState()
      : super(LanguageController(
            DataSettingRepository(), DataNavigationRepository()));

  Widget LanguageScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child,
    );
  }

  @override
  // TODO: implement desktopView
  Widget get desktopView => throw UnimplementedError();

  @override
  // TODO: implement mobileView
  Widget get mobileView => LanguageScaffold(child: _buildLanguageFormWidget());

  @override
  // TODO: implement tabletView
  Widget get tabletView => throw UnimplementedError();

  @override
  // TODO: implement watchView
  Widget get watchView => throw UnimplementedError();

  Widget _buildLanguageFormWidget() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 35.0, bottom: 8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  // Expanded cho iconBackButton

                  iconBackButton,

                  selectLanguageText,
                ],
              ),
              getLanguageCards,
            ],
          ),
        ),
      ),
    );
  }

  // Language Cards
  Widget get getLanguageCards =>
      clean_architecture.ControlledWidgetBuilder<LanguageController>(
          builder: (context, controller) {
        return GridView.builder(
            itemCount: Resources.languages.length,
            padding: const EdgeInsets.all(15.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10, // Spacing between columns
              mainAxisSpacing: 10, // Spacing between rows
            ),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // Handle onTap event
                  print(
                      'Selected language: ${Resources.languages[index].name}');
                  controller.changeLanguage(
                      context, Resources.languages[index]);
                },
                child: Card(
                  elevation: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture(
                        url: Resources.languages[index].iconUrl,
                        width: 60,
                        height: 60,
                      ),
                      SizedBox(height: 10),
                      Text(
                        Resources.languages[index].name,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                /*
          // range language load show card and th e index used to get code for to change language
          children: Resources.languages.e   
            final int index = entry.key;
            final Language language = entry.value;
            return LanguageCard(
                iconUrl: language['iconUrl'] ?? 'vi',
                name: language['name']!,
                // onTap change language from controller
                onTap: () {
                  Log.d("getLanguageCards pressed, code $language['code']! ",
                      "LanguagePage");
                  controller.changeLanguage(context, language['code']!);
                });
          }).toList(),
        );
        */
              );
            });
      });

  // Select Language Text
  Widget get selectLanguageText {
    final appLocalization = AppLocalizations.of(context);
    if (appLocalization != null) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            appLocalization.languageSelectLanguage,
            style: TextStyle(
                fontSize: ConfigFontSize.sizeLanguageSelectLabel,
                fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget get iconBackButton {
    return clean_architecture.ControlledWidgetBuilder<LanguageController>(
      builder: (context, controller) {
        return Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
              icon: const FaIcon(FontAwesomeIcons.angleLeft),
              onPressed: () {
                Log.d("iconBackButton pressed", runtimeType);
                controller.backNavigationPage();
              }),
        );
      },
    );
  }
}
