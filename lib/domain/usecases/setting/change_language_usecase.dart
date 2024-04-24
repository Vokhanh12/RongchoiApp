import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/utils/language.dart';
import 'package:rongchoi_app/domain/repositories/setting_repository.dart';
import 'package:rongchoi_app/main.dart';

class ChangeLanguageUseCase
    extends CompletableUseCase<ChangeLanguageUseCaseParams> {
  final SettingRepository _settingRepository;

  // constructor
  ChangeLanguageUseCase(this._settingRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      ChangeLanguageUseCaseParams? params) async {
      final StreamController<void> controller = StreamController<void>();
    try {
      // setting
      _settingRepository.changeLanguage(params!.context,params!.language);
      logger.finest('changeLanguageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (ex) {
      print(ex);
      logger.severe('changeLanguageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(ex);
    } finally {
      controller.close();
    }

    return controller.stream;
  }
}

class ChangeLanguageUseCaseParams {
  final BuildContext context;
  final Language language;

  ChangeLanguageUseCaseParams(this.context, this.language);
}
