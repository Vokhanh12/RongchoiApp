import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/login_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page/navigate_language_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page/navigate_login_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page/navigate_register_page_usecase.dart';

class LoginPresenter extends Presenter {
  // Data Repository
  final AuthenticationRepository _authenticationRepository;
  final NavigationRepository _navigationRepository;

  // UseCase
  late LoginUseCase _loginUseCase;
  late NavigateRegisterPageUseCase _navigateRegisterPageUseCase;
  late NavigateLanguagePageUseCase _navigateLanguagePageUseCase;

  // Observer Check status login
  late Function loginOnComplete; // alternatively `void loginOnComplete();`
  late Function loginOnError;
  late Function loginOnNext; // not needed in the case of a login presenter

  // Observer Check status goToRegisterPage
  late Function
      goToRegisterPageOnComplete; // alternatively `void goToRegisterPageOnComplete();`
  late Function goToRegisterPageOnError;
  late Function
      goToRegisterPageOnNext; // not needed in the case of a login presenter

  // Observer Check status goToLanguagePage
  late Function
      goToLanguagePageOnComplete; // alternatively `void goToLanguagePageOnComplete();`
  late Function goToLanguagePageOnError;
  late Function
      goToLanguagePageOnNext; // not needed in the case of a login presenter

  // dependency injection from controller
  LoginPresenter(this._authenticationRepository, this._navigationRepository) {
    // Initialize the [UseCase] with the appropriate repository
    // Login UseCase
    _loginUseCase = LoginUseCase(_authenticationRepository);
    // Navigate Register UseCase
    _navigateRegisterPageUseCase =
        NavigateRegisterPageUseCase(_navigationRepository);
    // Navigate Language UseCase
    _navigateLanguagePageUseCase =
        NavigateLanguagePageUseCase(_navigationRepository);
  }

  /// login function called by the controller
  void login({required String email, required String password}) {
    _loginUseCase.execute(
      _LoginUseCaseObserver(this),
      LoginUseCaseParams(email, password),
    );
  }

  /// goToRegisterPage function called by the controller
  void goToRegisterPage({required BuildContext context}) {
    _navigateRegisterPageUseCase.execute(
        _NavigateRegisterPageUseCaseObserver(this),
        NavigateRegisterPageUseCaseParams(context));
  }

  void goToLanguagePage({required BuildContext context}) {
    _navigateLanguagePageUseCase.execute(
        _NavigateLanguagePageUseCaseObserver(this),
        NavigateLanguagePageUseCaseParams(context));
  }

  /// Disposes of the [LoginUseCase] and unsubscribes
  @override
  void dispose() {
    _loginUseCase.dispose();
    _navigateLanguagePageUseCase.dispose();
    _navigateRegisterPageUseCase.dispose();
  }
}

/// The [Observer] used to observe the `Stream` of the [LoginUseCase]
class _LoginUseCaseObserver implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final LoginPresenter _loginPresenter;

  _LoginUseCaseObserver(this._loginPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Login is successful, trigger event in [LoginController]
  void onComplete() {
    // any cleaning or preparation goes here
    _loginPresenter.loginOnComplete();
  }

  /// Login was unsuccessful, trigger event in [LoginController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_loginPresenter.loginOnError != null) {
      _loginPresenter.loginOnError(e);
    }
  }
}

/// The [Observer] used to observe the `Stream` of the [NavigateRegisterPageUseCase]
class _NavigateRegisterPageUseCaseObserver implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final LoginPresenter _loginPresenter;

  _NavigateRegisterPageUseCaseObserver(this._loginPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Login is successful, trigger event in [LoginController]
  void onComplete() {
    // any cleaning or preparation goes here
    _loginPresenter.loginOnComplete();
  }

  /// Login was unsuccessful, trigger event in [LoginController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_loginPresenter.goToRegisterPageOnError != null) {
      _loginPresenter.goToRegisterPageOnError(e);
    }
  }
}

/// The [Observer] used to observe the `Stream` of the [NavigateLanguagePageUseCase]
class _NavigateLanguagePageUseCaseObserver implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final LoginPresenter _loginPresenter;

  _NavigateLanguagePageUseCaseObserver(this._loginPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Login is successful, trigger event in [LoginController]
  void onComplete() {
    // any cleaning or preparation goes here
    _loginPresenter.goToLanguagePageOnComplete();
  }

  /// Login was unsuccessful, trigger event in [LoginController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_loginPresenter.goToLanguagePageOnError != null) {
      _loginPresenter.goToLanguagePageOnError(e);
    }
  }
}
