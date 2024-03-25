import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/entities/language.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/page/back_navagation_page_usecase.dart';
import 'package:rongchoi_app/shared/build_config/system_config.dart';
import 'package:rongchoi_app/domain/repositories/setting_repository.dart';
import 'package:rongchoi_app/domain/usecases/setting/change_language_usecase.dart';

class LanguagePresenter extends Presenter {

  // Repository
  final SettingRepository _settingRepository;
  final NavigationRepository _navigationRepository;

  // UseCase
  late ChangeLanguageUseCase _changeLanguageUseCase;
  late BackNavigationPageUseCase _backNavigationPageUseCase;

  // Check status Observer [ChangLanguageUsecase]
  late Function
      changeLanguageOnComplete; // alternatively `void changeLanguageOnComplete();`
  late Function changeLanguageOnError;
  late Function
      changeLanguageOnNext; // not needed in the case of a changeLanguage presenter

  // Check status Observer [BackNavigationUseCase]
  late Function
      backNavigationPageOnComplete; // alternatively `void changeLanguageOnComplete();`
  late Function backNavigationPageOnError;
  late Function
      backNavigationPageOnNext; // not needed in the case of a changeLanguage presenter

  // constructor
  LanguagePresenter(this._settingRepository, this._navigationRepository) {
    _changeLanguageUseCase = ChangeLanguageUseCase(_settingRepository);
    _backNavigationPageUseCase = BackNavigationPageUseCase(_navigationRepository);
  }

  /// changeLanguage function called by the controller
  void changeLanguage(
      {required BuildContext context, required Language language}) {
    _changeLanguageUseCase.execute(_ChangeLanguageUseCaseObserver(this),
        ChangeLanguageUseCaseParams(context, language));
  }

  /// backNavigationPage function called by the controller
  void backNavigationPage({required BuildContext context}){
    _backNavigationPageUseCase.execute(_BackNavigationPageUseCaseObserver(this), BackNavigationPageUseCaseParams(context));
  }

  /// Disposes of the [ChangeLanguageUseCase] and unsubscribes
  @override
  void dispose() {
    // TODO: implement dispose
    _changeLanguageUseCase.dispose();
    _backNavigationPageUseCase.dispose();
  }
}

/// The [Observer] used to observe the `Stream` of the [ChangeLanguageUseCase]
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


/// The [Observer] used to observe the `Stream` of the [BackNavigationPageUseCase]
class _BackNavigationPageUseCaseObserver implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  late final LanguagePresenter _languagePresenter;

  _BackNavigationPageUseCaseObserver(this._languagePresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// change language is successful, trigger event in [ChangeLanguageController]
  void onComplete() {
    // any cleaning or preparation goes here
    _languagePresenter.backNavigationPageOnComplete;
  }

  /// change language was unsuccessful, trigger event in [ChangeLanguageController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_languagePresenter.changeLanguageOnError != null) {
      _languagePresenter._backNavigationPageUseCase;
    }
  }
}