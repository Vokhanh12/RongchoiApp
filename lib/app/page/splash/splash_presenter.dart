import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/get_auth_status_usecase.dart';

class SplashPresenter extends Presenter {
  final AuthenticationRepository _authenticationRepository;

  late GetAuthStatusUseCase _getAuthStatusUseCase;

  late Function getAuthStatusOnNext;
  late Function getAuthStatusOnComplete;

  // dependency injection from controller
  SplashPresenter(this._authenticationRepository) {
    // Initialize the [UseCase] with the appropriate repository
    _getAuthStatusUseCase = GetAuthStatusUseCase(_authenticationRepository);
  }

  void getAuthStatus() =>
      _getAuthStatusUseCase.execute(_GetAuthStatusUseCaseObserver(this));

  /// Disposes of the [GetAuthStatusUseCase] and unsubscribes
  void dispose() => _getAuthStatusUseCase.dispose();
}

/// The [Observer] used to observe the `Stream` of the [GetAuthUseCaseUseCase]
class _GetAuthStatusUseCaseObserver implements Observer<bool> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final SplashPresenter _splashPresenter;

  _GetAuthStatusUseCaseObserver(this._splashPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(bool? isAuth) {
       print('on Next');
    assert(_splashPresenter.getAuthStatusOnNext != null);
    _splashPresenter.getAuthStatusOnNext(isAuth);
  }

  /// Login is successful, trigger event in [SplashController]
  void onComplete() {
     print('on complete');
    assert(_splashPresenter.getAuthStatusOnComplete != null);
    _splashPresenter.getAuthStatusOnComplete();
  }

  @override
  void onError(e) {
    // if any errors occured, proceed as if the user is not logged in
    print('splash error');
    assert(_splashPresenter.getAuthStatusOnNext != null);
    _splashPresenter.getAuthStatusOnNext(false);
    onComplete();
  }
}
