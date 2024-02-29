import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/language/language_controller.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/widgets/custom_text.dart';
import 'package:rongchoi_app/app/widgets/language_card.dart';
import 'package:rongchoi_app/app/utils/screen_config.dart';
import 'package:rongchoi_app/app/utils/screen_size.dart';
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
  LanguagePageResponsiveViewState() : super(LanguageController(DataSettingRepository));

  @override
  // TODO: implement desktopView
  Widget get desktopView => throw UnimplementedError();

  @override
  // TODO: implement mobileView
  Widget get mobileView => _buildLanguageFormWidget();

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
              left: 8.0, right: 8.0, top: 15.0, bottom: 8.0),
          child: Column(
            children: [
              selectLanguageText,
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
        return GridView.count(
          padding: const EdgeInsets.all(12.0),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: Resources.languages.asMap().entries.map((entry) {
            final int index = entry.key;
            final Map<String, String> language = entry.value;
            return LanguageCard(
              iconUrl: language['iconUrl']!,
              name: language['name']!,
              onTap: (){ controller.changeLanguage(context,language['code']!);},
            );
          }).toList(),
        );
      });

  // Select Language Text
  Widget get selectLanguageText {
    final appLocalization = AppLocalizations.of(context);
    if (appLocalization != null) {
      return Text(
        appLocalization.languageSelectLanguage,
        style: TextStyle(
            fontSize: ScreenConfig.sizeLanguageSelectLabel,
            fontWeight: FontWeight.w600),
      );
    } else {
      return Container();
    }
  }
}
