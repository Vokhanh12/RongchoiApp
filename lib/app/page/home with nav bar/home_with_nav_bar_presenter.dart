import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_other_tab_in_home_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_social_media_page.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_store_page.dart';

class HomeWithNavBarPresenter extends clean_architecture.Presenter {
  // Repository
  final NavigationRepository _navigationRepository;

  // Observer Check status
  late Function
      goToStorePageOnComplete; // alternatively `void goToLoginOnComplete();`
  late Function goToStorePageOnError;
  late Function
      goToStorePageOnNext; // not needed in the case of a login presenter

  // Observer Check status
  late Function
      goToMediaSocialPageOnComplete; // alternatively `void goToLoginOnComplete();`
  late Function goToMediaSocialPageOnError;
  late Function
      goToMediaSocialPageOnNext; // not needed in the case of a login presenter

  // Observer Check status
  late Function
      goToOtherTabInHomePageOnComplete; // alternatively `void goToLoginOnComplete();`
  late Function goToOtherTabInHomePageOnError;
  late Function
      goToOtherTabInHomePageOnNext; // not needed in the case of a login presenter

  // UseCase
  late final NavigateStorePageUseCase _navigateStorePageUseCase;
  late final NavigateMediaSocialPageUseCase _navigateMediaSocialPageUseCase;
  late final NavigateOtherTabInHomePageUseCase
      _navigateOtherTabInHomePageUseCase;

  HomeWithNavBarPresenter(this._navigationRepository) {
    _navigateMediaSocialPageUseCase =
        NavigateMediaSocialPageUseCase(_navigationRepository);
    _navigateStorePageUseCase = NavigateStorePageUseCase(_navigationRepository);
    _navigateOtherTabInHomePageUseCase =
        NavigateOtherTabInHomePageUseCase(_navigationRepository);
  }

  void goToOtherTab(BuildContext context, int index) {
    _navigateOtherTabInHomePageUseCase.execute(
        _NavOtherTabInHomePageUseCaseObserver(this),
        NavOtherTabInHomePageUseCaseParams(context, index));
  }

  void goToStorePage(BuildContext context) {
    _navigateStorePageUseCase.execute(
        _NavStorePageUseCaseObserver(this), NavStorePageUseCaseParams(context));
  }

  void goToMediaSocialPage(BuildContext context) {
    _navigateMediaSocialPageUseCase.execute(
        _NavMediaSocialPageUseCaseObserver(this),
        NavMediaSocialPageUseCaseParams(context));
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _navigateMediaSocialPageUseCase.dispose();
    _navigateStorePageUseCase.dispose();
  }
}

// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavStorePageUseCaseObserver
    implements clean_architecture.Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final HomeWithNavBarPresenter _homeWithNavBarPresenter;

  _NavStorePageUseCaseObserver(this._homeWithNavBarPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Navigate Language is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _homeWithNavBarPresenter.goToStorePageOnComplete();
  }

  /// Navigate Language is unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_homeWithNavBarPresenter.goToStorePageOnError != null) {
      _homeWithNavBarPresenter.goToStorePageOnError(e);
    }
  }
}

// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavMediaSocialPageUseCaseObserver
    implements clean_architecture.Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final HomeWithNavBarPresenter _homeWithNavBarPresenter;

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
        clean_architecture.Observer<NavOtherTabInHomePageUseCaseResponse> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final HomeWithNavBarPresenter _presenter;

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
