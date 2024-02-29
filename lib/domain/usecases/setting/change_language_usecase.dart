import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
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
    // TODO: implement buildUseCaseStream
    final StreamController controller = StreamController();
    try {
      _settingRepository.changeLanguage(
          context: params!.context, code: params!.code);
      logger.finest('changeLanguageUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (ex) {
      print(ex);
      logger.severe('changeLanguageUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(ex);
    }

    return controller.stream;
  }
}

class ChangeLanguageUseCaseParams {
  final BuildContext context;
  final String code;

  ChangeLanguageUseCaseParams(this.context, this.code);
}
