import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:http/http.dart';
import 'package:rongchoi_app/domain/utils/form_register.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/register_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_confirm_registration_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_language_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_login_page_usecase.dart';

class RegisterPresenter extends clean_architecture.Presenter {
  // Repository
  final AuthenticationRepository _authenticationRepository;
  final NavigationRepository _navigationRepository;

  // UseCase
  late final RegisterUseCase _registerUseCase;
  late final NavigateLoginPageUseCase _navLoginPageUseCase;
  late final NavigateLanguagePageUseCase _navLanguagePageUseCase;
  late final NavigateConfirmRegistrationPageUseCase _navConRegisPageUseCase;

  // Observer Check status
  late Function registerOnComplete; // alternatively `void loginOnComplete();`
  late Function registerOnError;
  late Function
      registerOnNext; // not needed in the case of a Navigate Language presenter

  // Observer Check status
  late Function
      goToLoginPageOnComplete; // alternatively `void goToLoginOnComplete();`
  late Function goToLoginPageOnError;
  late Function
      goToLoginPageOnNext; // not needed in the case of a login presenter

  // Observer Check status
  late Function
      goToLanguagePageOnComplete; // alternatively `void goToLanguageOnComplete();`
  late Function goToLanguagePageOnError;
  late Function
      goToLanguagePageOnNext; // not needed in the case of a Navigate Language presenter

  // Observer Check status
  late Function
      goToConRegisPageOnComplete; // alternatively `void goToLanguageOnComplete();`
  late Function goToConRegisPageOnError;
  late Function
      goToConRegisPageOnNext; // not needed in the case of a Navigate Language presenter

  // Constuctor
  // dependency injection from controller
  RegisterPresenter(
      this._authenticationRepository, this._navigationRepository) {
    _registerUseCase = RegisterUseCase(_authenticationRepository);
    _navLanguagePageUseCase =
        NavigateLanguagePageUseCase(_navigationRepository);
    _navLoginPageUseCase = NavigateLoginPageUseCase(_navigationRepository);
    _navConRegisPageUseCase =
        NavigateConfirmRegistrationPageUseCase(_navigationRepository);
  }

  /// Navigate Languagefunction called by the controller
  void register(
      {required String firstName,
      required String lastName,
      required String username,
      required String password,
      required String rePassword,
      required String numberPhone}) {
    _registerUseCase.execute(
        _RegisterUseCaseObserver(this),
        RegisterUseCaseParams(FormRegister(firstName,lastName, username, password, rePassword, numberPhone)));
  }

  void goToLanguagePage(BuildContext context) {
    _navLanguagePageUseCase.execute(_NavigateLanguagePageUseCaseObserver(this),
        NavigateLanguagePageUseCaseParams(context));
  }

  void goToLoginPage(BuildContext context) {
    _navLoginPageUseCase.execute(_NavigateLoginPageUseCaseObserver(this),
        NavigateLoginPageUseCaseParams(context));
  }

  void goToConRegisPage(BuildContext context, FormRegister formRegis){
    _navConRegisPageUseCase.execute(_NavConRegisPageUseCaseObserver(this),
    NavConRegisPageUseCaseParams(context, formRegis));
  }

  /// Initializes [Presenter] listeners
  @override
  void dispose() {
    _registerUseCase.dispose();
    _navLanguagePageUseCase.dispose();
    _navLoginPageUseCase.dispose();
    _navConRegisPageUseCase.dispose();
  }
}

/// The [Observer] used to observe the `Stream` of the [RegisterUseCase]
class _RegisterUseCaseObserver implements clean_architecture.Observer<RegisterUseCaseResponse> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final RegisterPresenter _registerPresenter;

  _RegisterUseCaseObserver(this._registerPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  @override
  void onNext(response) {
      _registerPresenter.registerOnNext(response!.formRegister);
  }

  @override
  /// Navigate Languageis successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _registerPresenter.registerOnComplete();
  }

  @override
  /// Navigate Languagewas unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_registerPresenter.registerOnError != null) {
      _registerPresenter.registerOnError(e);
    }
  }
}

/// The [Observer] used to observe the `Stream` of the [NavigateLanguagePageUseCase]
class _NavigateLanguagePageUseCaseObserver
    implements clean_architecture.Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final RegisterPresenter _registerPresenter;

  _NavigateLanguagePageUseCaseObserver(this._registerPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Navigate Language is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _registerPresenter.goToLanguagePageOnComplete;
  }

  /// Navigate Language is unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_registerPresenter.goToLanguagePageOnError != null) {
      _registerPresenter.goToLanguagePageOnError(e);
    }
  }
}

// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavigateLoginPageUseCaseObserver
    implements clean_architecture.Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final RegisterPresenter _registerPresenter;

  _NavigateLoginPageUseCaseObserver(this._registerPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Navigate Language is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _registerPresenter.goToLoginPageOnComplete();
  }

  /// Navigate Language is unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes rere
    if (_registerPresenter.registerOnError != null) {
      _registerPresenter.goToLoginPageOnError(e);
    }
  }
}

// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavConRegisPageUseCaseObserver
    implements clean_architecture.Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final RegisterPresenter _registerPresenter;

  _NavConRegisPageUseCaseObserver(this._registerPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Navigate Language is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _registerPresenter.goToConRegisPageOnComplete;
  }

  /// Navigate Language is unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_registerPresenter.goToConRegisPageOnComplete != null) {
      _registerPresenter.goToConRegisPageOnError(e);
    }
  }
}
