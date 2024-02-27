import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/language/language_controller.dart';

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
  Widget get mobileView => throw UnimplementedError();

  @override
  // TODO: implement tabletView
  Widget get tabletView => throw UnimplementedError();

  @override
  // TODO: implement watchView
  Widget get watchView => throw UnimplementedError();
}
