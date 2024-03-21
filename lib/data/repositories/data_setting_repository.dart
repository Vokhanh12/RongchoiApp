import 'package:flutter/material.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/domain/entities/language.dart';
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
  Future<void> changeLanguage(BuildContext context, Language language) async {
    try {
      print("Attempting to change language to ${language.code}");
      MyApp.of(context)!
          .setLocale(Locale.fromSubtags(languageCode: language.code));
      print("Success: Language changed to ${language.code}");
    } catch (error) {
      // Xử lý lỗi một cách chính xác
      print("Error occurred while changing language:");
      print(error);
      throw error; // Throw lỗi để cho lớp gọi có thể xử lý tiếp
    }
  }
}
