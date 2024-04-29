import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/home/home_presenter.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/logout_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_login_page_usecase.dart';

class PersonalPresenter extends clean_architecture.Presenter {
  // Repository
  final NavigationRepository _navRepo;
  final AuthenticationRepository _authRepo;

  // UseCase
  late final LogoutUseCase _logoutUseCase;
  late final NavigateLoginPageUseCase _navLoginPageUseCase;


  // Check status Observer [LogoutUsecase]
  late Function logoutOnNext;
  late Function logoutOnComplete;
  late Function logoutOnError;


    
  // Observer Check status
  late Function
      goToLoginPageOnComplete; // alternatively `void goToLoginOnComplete();`
  late Function goToLoginPageOnError;
  late Function
      goToLoginPageOnNext; // not needed in the case of a login presenter


  PersonalPresenter(this._navRepo, this._authRepo) {
    _logoutUseCase = LogoutUseCase(_authRepo);

  }

  void logout() {
    _logoutUseCase.execute(
      _LogoutUseCaseObserver(this),
    );
  }

  void goToLoginPage({required BuildContext context}) {
    _navLoginPageUseCase.execute(_NavigateLoginPageUseCaseObserver(this),
        NavigateLoginPageUseCaseParams(context));
  }

  @override
  void dispose() {
    _logoutUseCase.dispose();
    _navLoginPageUseCase.dispose();

  }
}

class _LogoutUseCaseObserver
    extends clean_architecture.Observer<LogoutUseCaseResponse> {
  final PersonalPresenter presenter;
  _LogoutUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.logoutOnComplete();
  }

  @override
  void onError(e) {
    presenter.logoutOnError(e);
  }

  @override
  void onNext(response) {
    presenter.logoutOnNext(response!.status);
  }
}

// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavigateLoginPageUseCaseObserver
    implements clean_architecture.Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final PersonalPresenter _presenter;

  _NavigateLoginPageUseCaseObserver(this._presenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Navigate Language is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _presenter.goToLoginPageOnComplete();
  }

  /// Navigate Language is unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_presenter.goToLoginPageOnError != null) {
      _presenter.goToLoginPageOnError(e);
    }
  }
}
