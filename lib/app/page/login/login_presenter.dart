import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/usecases/auth/login_usecase.dart';

class LoginPresenter{

  late Function loginOnComplete; // alternatively `void loginOnComplete();`
  late Function loginOnError;
  late Function loginOnNext; // not needed in the case of a login presenter

  final LoginUseCase loginUseCase;
  // dependency injection from controller
  LoginPresenter(authenticationRepo): loginUseCase = LoginUseCase(authenticationRepo);

  /// login function called by the controller
  void login(String email, String password) {
    loginUseCase.execute(_LoginUseCaseObserver(this), LoginUseCaseParams(email, password));
  }


   /// Disposes of the [LoginUseCase] and unsubscribes
   @override
   void dispose() {
     loginUseCase.dispose();
   }
}

/// The [Observer] used to observe the `Stream` of the [LoginUseCase]
class _LoginUseCaseObserver implements Observer<void> {

  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final LoginPresenter loginPresenter;

  _LoginUseCaseObserver(this.loginPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Login is successful, trigger event in [LoginController]
  void onComplete() {
    // any cleaning or preparation goes here
    assert(loginPresenter.loginOnComplete != null);
    loginPresenter.loginOnComplete();

  }

  /// Login was unsuccessful, trigger event in [LoginController]
  void onError(e) {
    // any cleaning or preparation goes here
    assert(loginPresenter.loginOnError != null);
    loginPresenter.loginOnError(e);
  }
}
