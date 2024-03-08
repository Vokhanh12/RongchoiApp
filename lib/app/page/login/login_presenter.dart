import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/login_usecase.dart';

class LoginPresenter extends Presenter {
  
  final AuthenticationRepository _authenticationRepository;
  
  late LoginUseCase _loginUseCase;

  late Function loginOnComplete; // alternatively `void loginOnComplete();`
  late Function loginOnError;
  late Function loginOnNext; // not needed in the case of a login presenter

  // dependency injection from controller

  LoginPresenter(this._authenticationRepository) {
    // Initialize the [UseCase] with the appropriate repository
    _loginUseCase = LoginUseCase(_authenticationRepository);
  }

  /// login function called by the controller
  void login({required String email, required String password}) {
    _loginUseCase.execute(
        _LoginUseCaseObserver(this), LoginUseCaseParams(email, password),);
  }

  /// Disposes of the [LoginUseCase] and unsubscribes
  @override
  void dispose() {
    _loginUseCase.dispose();
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
