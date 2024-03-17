import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/shared/build_config/system_config.dart';
import 'package:rongchoi_app/domain/repositories/setting_repository.dart';
import 'package:rongchoi_app/domain/usecases/setting/change_language_usecase.dart';

class LanguagePresenter extends Presenter {
  
  final SettingRepository _settingRepository;

  late ChangeLanguageUseCase _changeLanguageUseCase;

  late Function changeLanguageOnComplete; // alternatively `void changeLanguageOnComplete();`
  late Function changeLanguageOnError;
  late Function changeLanguageOnNext; // not needed in the case of a changeLanguage presenter

  // constructor
  LanguagePresenter(this._settingRepository){
    _changeLanguageUseCase = ChangeLanguageUseCase(_settingRepository);
  }


    /// changeLanguage function called by the controller
  void changeLanguage({required BuildContext context, required String code}) {
    

    _changeLanguageUseCase.execute(
      _ChangeLanguageUseCaseObserver(this), ChangeLanguageUseCaseParams(context, code));
  }


  /// Disposes of the [ChangeLanguageUseCase] and unsubscribes
  @override
  void dispose() {
    // TODO: implement dispose
    _changeLanguageUseCase.dispose();
  }

}

/// The [Observer] used to observe the `Stream` of the [LoginUseCase]
class _ChangeLanguageUseCaseObserver implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  late final LanguagePresenter _languagePresenter;

  _ChangeLanguageUseCaseObserver(this._languagePresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// change language is successful, trigger event in [ChangeLanguageController]
  void onComplete() {
    // any cleaning or preparation goes here
    _languagePresenter.changeLanguageOnComplete();
  }

  /// change language was unsuccessful, trigger event in [ChangeLanguageController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_languagePresenter.changeLanguageOnError != null) {
      _languagePresenter.changeLanguageOnError(e);
    }
  }
}
