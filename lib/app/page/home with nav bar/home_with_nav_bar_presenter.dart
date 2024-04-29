import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_job_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_other_tab_in_home_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_personal_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_social_media_page.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_store_page.dart';

class HomeWithNavBarPresenter extends Presenter {
  // Repository
  final NavigationRepository _navRepo;

  // Observer Check status
  late Function
      goToStorePageOnComplete; // alternatively `void goToLoginOnComplete();`
  late Function goToStorePageOnError;
  late Function
      goToStorePageOnNext; // not needed in the case of a login presenter

  // Observer Check status
  late Function
      goToJobPageOnComplete; // alternatively `void goToLoginOnComplete();`
  late Function goToJobPageOnError;
  late Function
      goToJobPageOnNext; // not needed in the case of a login presenter

  // Observer Check status
  late Function
      goToPersonalPageOnComplete; // alternatively `void goToLoginOnComplete();`
  late Function goToPersonalPageOnError;
  late Function
      goToPersonalPageOnNext; // not needed in the case of a login presenter

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

  late final NavigateStorePageUseCase _navStorePageUseCase;
  late final NavigateMediaSocialPageUseCase _navMediaSocialPageUseCase;
  late final NavigateOtherTabInHomePageUseCase _navOtherTabInHomePageUseCase;
  late final NavigateJobPageUseCase _navJobPageUsecase;
  late final NavigatePersonalPageUseCase _navPersonalPageUsecase;

  HomeWithNavBarPresenter(this._navRepo) {
    _navStorePageUseCase = NavigateStorePageUseCase(_navRepo);

    _navMediaSocialPageUseCase = NavigateMediaSocialPageUseCase(_navRepo);

    _navOtherTabInHomePageUseCase = NavigateOtherTabInHomePageUseCase(_navRepo);

    _navJobPageUsecase = NavigateJobPageUseCase(_navRepo);

    _navPersonalPageUsecase = NavigatePersonalPageUseCase(_navRepo);
  }

  void goToOtherTab(BuildContext context, int index) {
    _navOtherTabInHomePageUseCase.execute(
        _NavOtherTabInHomePageUseCaseObserver(this),
        NavOtherTabInHomePageUseCaseParams(context, index));
  }

  void goToJobPage(BuildContext context) {
    _navJobPageUsecase.execute(
        _NavJobPageUseCaseObserver(this), NavJobPageUseCaseParams(context));
  }

  void goToPersonal(BuildContext context) {
    _navPersonalPageUsecase.execute(_NavJobPageUseCaseObserver(this),
        NavPersonalPageUseCaseParams(context));
  }

  void goToStorePage(BuildContext context) {
    _navStorePageUseCase.execute(
        _NavStorePageUseCaseObserver(this), NavStorePageUseCaseParams(context));
  }

  void goToMediaSocialPage(BuildContext context) {
    _navMediaSocialPageUseCase.execute(_NavMediaSocialPageUseCaseObserver(this),
        NavMediaSocialPageUseCaseParams(context));
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _navMediaSocialPageUseCase.dispose();
    _navStorePageUseCase.dispose();

    _navOtherTabInHomePageUseCase.dispose();

    _navMediaSocialPageUseCase.dispose();

    _navStorePageUseCase.dispose();

    _navJobPageUsecase.dispose();

    _navPersonalPageUsecase.dispose();
  }
}

// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavStorePageUseCaseObserver implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final HomeWithNavBarPresenter _presenter;

  _NavStorePageUseCaseObserver(this._presenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Navigate Language is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _presenter.goToStorePageOnComplete();
  }

  /// Navigate Language is unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_presenter.goToStorePageOnError != null) {
      _presenter.goToStorePageOnError(e);
    }
  }
}

// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavMediaSocialPageUseCaseObserver implements Observer<void> {
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
    implements Observer<NavOtherTabInHomePageUseCaseResponse> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final HomeWithNavBarPresenter _presenter;

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

// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavJobPageUseCaseObserver implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final HomeWithNavBarPresenter _presenter;

  _NavJobPageUseCaseObserver(this._presenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Navigate Language is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _presenter.goToJobPageOnComplete();
  }

  /// Navigate Language is unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_presenter.goToJobPageOnError != null) {
      _presenter.goToJobPageOnError(e);
    }
  }
}

// The [Observer] used to observe the `Stream` of the [NavigateLoginPageUseCase]
class _NavPersonalPageUseCaseObserver implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  final HomeWithNavBarPresenter _presenter;

  _NavPersonalPageUseCaseObserver(this._presenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Navigate Language is successful, trigger event in [RegisterController]
  void onComplete() {
    // any cleaning or preparation goes here
    _presenter.goToPersonalPageOnComplete();
  }

  /// Navigate Language is unsuccessful, trigger event in [RegisterController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_presenter.goToPersonalPageOnError != null) {
      _presenter.goToPersonalPageOnError(e);
    }
  }
}
