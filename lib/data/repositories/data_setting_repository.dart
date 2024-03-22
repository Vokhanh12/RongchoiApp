import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rongchoi_app/app/page/language/cubit/language_cubit.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/utils/log.dart';
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
      Log.d("Attempting to change language to ${language.code}", runtimeType);

      context.read<LanguageCubit>().changeLanguage(language);

      MyApp.of(context)!
          .setLocale(Locale.fromSubtags(languageCode: language.code));

      Log.d("Success: Language changed to ${language.code}", runtimeType);
      _logger.finest('Changelanguage Successful.');
    } catch (ex) {
      // Xử lý lỗi một cách chính xác
      Log.d("Error occurred while changing language: $ex", runtimeType);
      _logger.warning(ex);
      rethrow;
    }
  }
}
