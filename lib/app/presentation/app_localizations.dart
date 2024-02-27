import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rongchoi_app/app/utils/constants.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationDelagate();

 static AppLocalizations? of(BuildContext context) {
  return Localizations.of<AppLocalizations>(context, AppLocalizations);
}

  late Map<String, String> _localisedString;

  Future<bool> load() async {
    final jsonString = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localisedString =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

 String translate(String key) {
  return _localisedString[key] ?? 'Translation not found for key: $key';
}
}

class _AppLocalizationDelagate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationDelagate();

  @override
  bool isSupported(Locale locale) {
    return Languages.languages
        .map((e) => e.code)
        .toList()
        .contains(locale.languageCode);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) {
    return false;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }
}
