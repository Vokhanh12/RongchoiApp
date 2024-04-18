import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/logout_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_login_page_usecase.dart';

import '../../../domain/usecases/user/get_user_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;

class HomePresenter extends clean_architecture.Presenter {
  // Repository
  final AuthenticationRepository _authRepo;
  final UsersRepository _usersRepo;
  final NavigationRepository _navigationRepository;

  // Check status Observer [GetUserUsecase]
  late Function getUserOnNext;
  late Function getUserOnComplete;
  late Function getUserOnError;

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

  // UseCase
  late final GetUserUseCase getUserUseCase;
  late final LogoutUseCase logoutUseCase;
  late final NavigateLoginPageUseCase navigateLoginPageUseCase;

  HomePresenter(this._usersRepo, this._authRepo, this._navigationRepository) {
    getUserUseCase = GetUserUseCase(_usersRepo);
    logoutUseCase = LogoutUseCase(_authRepo);
    navigateLoginPageUseCase = NavigateLoginPageUseCase(_navigationRepository);
  }

  void getUser(String uid) {
    // execute getUseruserCase
    getUserUseCase.execute(
      _GetUserUseCaseObserver(this),
      GetUserUseCaseParams(uid),
    );
  }

  void logout() {
    logoutUseCase.execute(
      _LogoutUseCaseObserver(this),
    );
  }

  
  void goToLoginPage({required BuildContext context}) {
    navigateLoginPageUseCase.execute(
        _NavigateLoginPageUseCaseObserver(this),
        NavigateLoginPageUseCaseParams(context));
  }

  @override
  void dispose() {
    getUserUseCase.dispose();
  }
}

class _GetUserUseCaseObserver
    extends clean_architecture.Observer<GetUserUseCaseResponse> {
  final HomePresenter presenter;
  _GetUserUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.getUserOnComplete();
  }

  @override
  void onError(e) {
    presenter.getUserOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getUserOnNext(response!.user);
  }
}

class _LogoutUseCaseObserver
    extends clean_architecture.Observer<LogoutUseCaseResponse> {
  final HomePresenter presenter;
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
  final HomePresenter _homePresenter;

  _NavigateLoginPageUseCaseObserver(this._homePresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Navigate Language is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _homePresenter.goToLoginPageOnComplete();
  }

  /// Navigate Language is unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_homePresenter.goToLoginPageOnError != null) {
      _homePresenter.goToLoginPageOnError(e);
    }
  }
}
