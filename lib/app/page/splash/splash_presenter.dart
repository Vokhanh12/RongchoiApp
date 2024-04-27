import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/get_auth_status_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_login_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_other_tab_in_home_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_social_media_page.dart';

class SplashPresenter extends Presenter {
  // Data Repository
  final AuthenticationRepository _authenticationRepository;
  final NavigationRepository _navigationRepository;

  // UseCase
  late GetAuthStatusUseCase _getAuthStatusUseCase;
  late NavigateLoginPageUseCase _navLoginPageUseCase;
  late NavigateOtherTabInHomePageUseCase _navOtherTabInHomePageUseCase;
  late NavigateMediaSocialPageUseCase _navMediaSocialPageUseCase;

  // Check Status Observer [GetAuthStatusUseCase]
  late Function getAuthStatusOnNext;
  late Function getAuthStatusOnComplete;

  // Check Status Observer [NavigateLoginPageUseCase]
  late Function goToLoginPageOnNext;
  late Function goToLoginPageOnComplete;
  late Function goToLoginPageError;

  // Check Status Observer [NavigateLoginPageUseCase]
  late Function goToHomePageOnNext;
  late Function goToHomePageOnComplete;
  late Function goToHomePageError;

    // Observer Check status
  late Function goToMediaSocialPageOnComplete; // alternatively `void goToLoginOnComplete();`
  late Function goToMediaSocialPageOnError;
  late Function goToMediaSocialPageOnNext; // not needed in the case of a login presenter

  // Observer Check status
  late Function goToOtherTabInHomePageOnComplete; // alternatively `void goToLoginOnComplete();`
  late Function goToOtherTabInHomePageOnError;
  late Function goToOtherTabInHomePageOnNext; // not needed in the case of a login presenter    


  


  // dependency injection from controller
  SplashPresenter(this._authenticationRepository, this._navigationRepository) {
    // Initialize the [UseCase] with the appropriate repository
    _getAuthStatusUseCase = GetAuthStatusUseCase(_authenticationRepository);
    _navLoginPageUseCase = NavigateLoginPageUseCase(_navigationRepository);
    _navOtherTabInHomePageUseCase = NavigateOtherTabInHomePageUseCase(_navigationRepository);
  }

  // Function Call Observer
  void getAuthStatus() =>
      _getAuthStatusUseCase.execute(_GetAuthStatusUseCaseObserver(this));

  void goToLoginPage( {required BuildContext context}) => _navLoginPageUseCase
      .execute(_NavigateLoginPageUseCaseObserver(this), NavigateLoginPageUseCaseParams(context));


 // Function
  void goToOtherTab(BuildContext context, int index) {
    _navOtherTabInHomePageUseCase.execute(
        _NavOtherTabInHomePageUseCaseObserver(this),
        NavOtherTabInHomePageUseCaseParams(context, index));
  }


  void goToMediaSocialPage(BuildContext context) {
    _navMediaSocialPageUseCase.execute(
        _NavMediaSocialPageUseCaseObserver(this),
        NavMediaSocialPageUseCaseParams(context));
  }



  /// Disposes of the [GetAuthStatusUseCase] and unsubscribes
  void dispose(){
    _getAuthStatusUseCase.dispose();
    _navLoginPageUseCase.dispose();
  } 
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
    assert(_splashPresenter.getAuthStatusOnNext != null);
    _splashPresenter.getAuthStatusOnNext(isAuth);
  }

  /// Login is successful, trigger event in [SplashController]
  void onComplete() {
    assert(_splashPresenter.getAuthStatusOnComplete != null);
    _splashPresenter.getAuthStatusOnComplete();
  }

  @override
  void onError(e) {
    // if any errors occured, proceed as if the user is not logged in
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
    assert(_splashPresenter.goToLoginPageOnComplete != null);
    _splashPresenter.goToLoginPageOnComplete();
  }

  @override
  void onError(e) {
    // if any errors occured, proceed as if the user is not logged in
    assert(_splashPresenter.getAuthStatusOnNext != null);
    _splashPresenter.goToLoginPageError();
  }

  @override
  void onNext(bool? response) {
    // TODO: implement onNext
  }
}


// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavMediaSocialPageUseCaseObserver
    implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final SplashPresenter _homeWithNavBarPresenter;

  _NavMediaSocialPageUseCaseObserver(this._homeWithNavBarPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Navigate Language is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _homeWithNavBarPresenter.goToMediaSocialPageOnComplete();
  }

  /// Navigate Language is unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_homeWithNavBarPresenter.goToMediaSocialPageOnError != null) {
      _homeWithNavBarPresenter.goToMediaSocialPageOnError(e);
    }
  }
}

// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavOtherTabInHomePageUseCaseObserver
    implements
      Observer<NavOtherTabInHomePageUseCaseResponse> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final SplashPresenter _presenter;

  _NavOtherTabInHomePageUseCaseObserver(this._presenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(response) {
    _presenter.goToOtherTabInHomePageOnNext(response!.context,response!.index);
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
