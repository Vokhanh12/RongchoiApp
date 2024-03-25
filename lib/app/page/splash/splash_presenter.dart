import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/get_auth_status_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page/navigate_login_page_usecase.dart';

class SplashPresenter extends Presenter {
  // Data Repository
  final AuthenticationRepository _authenticationRepository;
  final NavigationRepository _navigationRepository;

  // UseCase
  late GetAuthStatusUseCase _getAuthStatusUseCase;
  late NavigateLoginPageUseCase _navigateLoginPageUseCase;

  // Check Status Observer [GetAuthStatusUseCase]
  late Function getAuthStatusOnNext;
  late Function getAuthStatusOnComplete;

  // Check Status Observer [NavigateLoginPageUseCase]
  late Function goToLoginPageOnNext;
  late Function goToLoginPageOnComplete;
  late Function goToLoginPageError;

  // dependency injection from controller
  SplashPresenter(this._authenticationRepository, this._navigationRepository) {
    // Initialize the [UseCase] with the appropriate repository
    _getAuthStatusUseCase = GetAuthStatusUseCase(_authenticationRepository);
    _navigateLoginPageUseCase = NavigateLoginPageUseCase(_navigationRepository);
  }

  void getAuthStatus() =>
      _getAuthStatusUseCase.execute(_GetAuthStatusUseCaseObserver(this));

  void goToLoginPage( {required BuildContext context}) => _navigateLoginPageUseCase
      .execute(_NavigateLoginPageUseCaseObserver(this), NavigateLoginPageUseCaseParams(context));

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

/// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavigateLoginPageUseCaseObserver implements Observer<bool> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final SplashPresenter _splashPresenter;

  _NavigateLoginPageUseCaseObserver(this._splashPresenter);

  /// Navigate LoginPage is successful, trigger event in [SplashController]
  void onComplete() {
    print('on complete');
    assert(_splashPresenter.goToLoginPageOnComplete != null);
    _splashPresenter.goToLoginPageOnComplete();
  }

  @override
  void onError(e) {
    // if any errors occured, proceed as if the user is not logged in
    print('splash error');
    assert(_splashPresenter.getAuthStatusOnNext != null);
    _splashPresenter.goToLoginPageError();
  }

  @override
  void onNext(bool? response) {
    // TODO: implement onNext
  }
}
