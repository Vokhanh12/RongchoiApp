import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/register_usecase.dart';

class RegisterPresenter extends clean_architecture.Presenter {
  // UseCase
  late final RegisterUseCase _registerUseCase;

  // Repository
  final AuthenticationRepository _authenticationRepository;

  // Observer Check status
  late Function registerOnComplete; // alternatively `void loginOnComplete();`
  late Function registerOnError;
  late Function registerOnNext; // not needed in the case of a login presenter

  // Constuctor
  // dependency injection from controller
  RegisterPresenter(this._authenticationRepository) {
    _registerUseCase = RegisterUseCase(_authenticationRepository);
  }

  /// register function called by the controller
  void register(
      {required String firstName,
      required String lastName,
      required String username,
      required String password,
      required String rePassword,
      required String numberPhone}) {
    _registerUseCase.execute(
        _RegisterUseCaseObserver(this),
        RegisterUseCaseParams(
            firstName, lastName, username, password, rePassword, numberPhone));
  }

  /// Initializes [Presenter] listeners
  @override
  void dispose() {
    // TODO: implement dispose
  }
}

/// The [Observer] used to observe the `Stream` of the [RegisterUseCase]
class _RegisterUseCaseObserver implements clean_architecture.Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final RegisterPresenter _registerPresenter;

  _RegisterUseCaseObserver(this._registerPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Register is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _registerPresenter.registerOnComplete();
  }

  /// Register was unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_registerPresenter.registerOnError != null) {
      _registerPresenter.registerOnError(e);
    }
  }
}
