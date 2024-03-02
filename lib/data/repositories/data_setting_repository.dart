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
      print("Attempting to change language to $code");
      MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: code));
      print("Success: Language changed to $code");
    } catch (error) {
      // Xử lý lỗi một cách chính xác
      print("Error occurred while changing language:");
      print(error);
      throw error; // Throw lỗi để cho lớp gọi có thể xử lý tiếp
    }
  }
}
