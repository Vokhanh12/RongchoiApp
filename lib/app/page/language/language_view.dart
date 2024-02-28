import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/language/language_controller.dart';
import 'package:rongchoi_app/app/presentation/app_localizations.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/widgets/custom_text.dart';
import 'package:rongchoi_app/app/widgets/language_card.dart';
import 'package:rongchoi_app/app/widgets/screen_size.dart';

class LanguagePage extends clean_architecture.View {
  const LanguagePage({super.key});

  @override
  LanguagePageResponsiveViewState createState() =>
      LanguagePageResponsiveViewState();
}

class LanguagePageResponsiveViewState extends clean_architecture
    .ResponsiveViewState<LanguagePage, LanguageController> {
  LanguagePageResponsiveViewState() : super(LanguageController());

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
    return SingleChildScrollView(
      child:
    );
  }

  Widget get getCards => GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        children: Resources.languages.map((language) {
          return LanguageCard(
            iconUrl: language['iconUrl']!,
            name: language['name']!,
          );
        }).toList(),
      );

  Widget get selectLanguageText {
    final appLocalization = AppLocalizations.of(context);
        if (appLocalization != null) {
          return CustomText(text: appLocalization.languageSelectLanguage, fontSize: fontSize);
        } else {
          return Container();
        }

  }


}
