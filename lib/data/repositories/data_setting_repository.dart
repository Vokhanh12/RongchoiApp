import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/repositories/setting_repository.dart';
import 'package:logging/logging.dart';
import 'package:rongchoi_app/main.dart';

class DataSettingRepository extends SettingRepository {
  /// Singleton object of `DataAuthenticationRepository`
  static DataSettingRepository _instance = DataSettingRepository._internal();

  late Logger _logger;

  // Constructors
  DataSettingRepository._internal() {
    _logger = Logger('DataSettingRepository');
  }

  factory DataSettingRepository() => _instance;

  @override
  Future<void> changeLanguage(
      {required BuildContext context, required String code}) async {
    try {
      // TODO: implement changeLanguage
      print("success change language");
      MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: code));
    } catch (ex) {
      print("something bad happened");
      print(ex.runtimeType);
      print(ex);

      rethrow;
    }
  }
}
