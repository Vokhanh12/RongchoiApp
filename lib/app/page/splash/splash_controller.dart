import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/splash/splash_presenter.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/location_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';

class SplashController extends clean_architecture.Controller {
  late bool isLoading;

  final SplashPresenter _splashPresenter;
  final LocationRepository _locationRepository;

  SplashController(AuthenticationRepository authRepo,
      NavigationRepository navRepository, this._locationRepository)
      : _splashPresenter = SplashPresenter(authRepo, navRepository) {
    getAuthStatus();
    handlePermissions();
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    // Initialize presenter listeners here
    // These will be called upon success, failure, or data retrieval after usecase execution

    // Initialize [getAuthStatus]
    _splashPresenter.getAuthStatusOnNext = authStatusOnNext;
    _splashPresenter.getAuthStatusOnComplete = () => isLoading = false;

    // Initialize [goToLoginPage]
    _splashPresenter.goToLoginPageError = _goToLoginPageOnError;
    _splashPresenter.goToLoginPageOnComplete = _goToLoginPageOnComplete;

    // Initialize [goToMediaSocial]
    _splashPresenter.goToMediaSocialPageOnComplete = _goToMediaSocialOnComplete;
    _splashPresenter.goToMediaSocialPageOnError = _goToMediaSocialOnError;
    _splashPresenter.goToMediaSocialPageOnNext = _goToMediaSocialOnNext;
  }

  /// Initializes [animation] for the view using a given [controller]
  void initAnimation(AnimationController controller, Animation animation) {
    animation.addStatusListener((status) {
      if (!isLoading) {
        controller.stop(canceled: true);
        print("stop");
      } else if (status == AnimationStatus.completed) {
        controller.reverse();
        print("completed");
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
        print("dismissed");
      }
    });
    controller.forward();
  }

  void authStatusOnNext(bool isAuth) {
    // In the home page, setting up the social media tab is the first page.
    const HOME_PAGE = '/home';
    const LOGIN_PAGE = '/login';

    String page = isAuth ? HOME_PAGE : LOGIN_PAGE;

    if (page == HOME_PAGE) {
        GoRouter.of(getContext()).go(HOME_PAGE);
    } else {
      _splashPresenter.goToLoginPage(context: getContext());
    }

    // use go router
    //Navigator.of(getContext()).pushReplacementNamed(page);
  }

  /// Navigate is successful
  void _goToLoginPageOnComplete() {
    dismissLoading();
  }

  /// Navigate is error
  void _goToLoginPageOnError(e) {
    dismissLoading();
  }

  void getAuthStatus() async {
    isLoading = true;
    // so the animation can be seen
    Future.delayed(Duration(seconds: 3), _splashPresenter.getAuthStatus);
  }

  void handlePermissions() {
    _locationRepository.enableDevice();
  }

  void dispose() {
    _splashPresenter.dispose();
    super.dispose();
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  void _goToMediaSocialOnComplete() {}

  void _goToMediaSocialOnError(e) {}

  void _goToMediaSocialOnNext(bool status) {}
}
