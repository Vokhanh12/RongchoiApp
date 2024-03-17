import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/splash/splash_presenter.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';

class SplashController extends clean_architecture.Controller {
  late bool isLoading;

  final SplashPresenter _splashPresenter;

  SplashController(AuthenticationRepository authRepo)
      : _splashPresenter = SplashPresenter(authRepo) {
    getAuthStatus();
  }

  @override
  void initListeners() {
    // TODO: implement initListeners
    _splashPresenter.getAuthStatusOnNext = authStatusOnNext;
    _splashPresenter.getAuthStatusOnComplete = () => isLoading = false;
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
    String page = isAuth ? '/home' : '/login';

    // use go router
    //Navigator.of(getContext()).pushReplacementNamed(page);
  }

  void getAuthStatus() async {
    isLoading = true;
    // so the animation can be seen
    Future.delayed(Duration(seconds: 3), _splashPresenter.getAuthStatus);
  }
}
