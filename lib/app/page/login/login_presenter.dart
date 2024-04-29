import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/login_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_home_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_language_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_login_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_other_tab_in_home_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_register_page_usecase.dart';

class LoginPresenter extends Presenter {
  // Data Repository
  final AuthenticationRepository _authenticationRepository;
  final NavigationRepository _navigationRepository;

  // UseCase
  late LoginUseCase _loginUseCase;
  late NavigateRegisterPageUseCase _navigateRegisterPageUseCase;
  late NavigateLanguagePageUseCase _navigateLanguagePageUseCase;
  late NavigateHomePageUseCase _navigateHomePageUseCase;
  late final NavigateOtherTabInHomePageUseCase _navOtherTabInHomePageUseCase;

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

  // Observer Check status goToHomePage
  late Function
      goToHomePageOnComplete; // alternatively `void goToHomePageOnComplete();`
  late Function goToHomePageOnError;
  late Function
      goToHomePageOnNext; // not needed in the case of a login presenter
  // dependency injection from controller

  // Observer Check status
  late Function
      goToOtherTabInHomePageOnComplete; // alternatively `void goToLoginOnComplete();`
  late Function goToOtherTabInHomePageOnError;
  late Function
      goToOtherTabInHomePageOnNext; // not needed in the case of a login presenter

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
    // Navigate Home UseCase
    _navigateHomePageUseCase = NavigateHomePageUseCase(_navigationRepository);

    _navOtherTabInHomePageUseCase =
        NavigateOtherTabInHomePageUseCase(_navigationRepository);
  }

  /// login function called by the controller
  void login({required String email, required String password}) {
    _loginUseCase.execute(
      _LoginUseCaseObserver(this),
      LoginUseCaseParams(email, password),
    );
  }

  // Function
  void goToOtherTab(BuildContext context, int index) {
    _navOtherTabInHomePageUseCase.execute(
        _NavOtherTabInHomePageUseCaseObserver(this),
        NavOtherTabInHomePageUseCaseParams(context, index));
  }

  /// goToRegisterPage function called by the controller
  void goToRegisterPage({required BuildContext context}) {
    _navigateRegisterPageUseCase.execute(
        _NavigateRegisterPageUseCaseObserver(this),
        NavigateRegisterPageUseCaseParams(context));
  }

  /// goToLanguagePage function called by the controller
  void goToLanguagePage({required BuildContext context}) {
    _navigateLanguagePageUseCase.execute(
        _NavigateLanguagePageUseCaseObserver(this),
        NavigateLanguagePageUseCaseParams(context));
  }

  /// goToHomePage function called by the controller
  void goToHomePage({required BuildContext context}) {
    _navigateHomePageUseCase.execute(_NavigateHomePageUseCaseObserver(this),
        NavigateHomePageUseCaseParams(context));
  }

  /// Disposes of the [LoginUseCase] and unsubscribes
  @override
  void dispose() {
    _loginUseCase.dispose();
    _navigateLanguagePageUseCase.dispose();
    _navigateRegisterPageUseCase.dispose();
    _navigateHomePageUseCase.dispose();
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
    _loginPresenter.loginOnComplete!();
  }

  /// Login was unsuccessful, trigger event in [LoginController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_loginPresenter.loginOnError != null) {
      _loginPresenter.loginOnError!(e);
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
    _loginPresenter.goToHomePageOnComplete();
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

/// The [Observer] used to observe the `Stream` of the [NavigateHomePageUseCase]
class _NavigateHomePageUseCaseObserver implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final LoginPresenter _loginPresenter;

  _NavigateHomePageUseCaseObserver(this._loginPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Login is successful, trigger event in [LoginController]
  void onComplete() {
    // any cleaning or preparation goes here
    _loginPresenter.goToHomePageOnComplete();
  }

  /// Login was unsuccessful, trigger event in [LoginController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_loginPresenter.goToLanguagePageOnError != null) {
      _loginPresenter.goToHomePageOnError(e);
    }
  }
}

// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavOtherTabInHomePageUseCaseObserver
    implements Observer<NavOtherTabInHomePageUseCaseResponse> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final LoginPresenter _presenter;

  _NavOtherTabInHomePageUseCaseObserver(this._presenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(response) {
    _presenter.goToOtherTabInHomePageOnNext(response!.context, response!.index);
  }

  /// Navigate Language is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _presenter.goToOtherTabInHomePageOnComplete();
  }

  /// Navigate Language is unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_presenter.goToOtherTabInHomePageOnError != null) {
      _presenter.goToOtherTabInHomePageOnError(e);
    }
  }
}
