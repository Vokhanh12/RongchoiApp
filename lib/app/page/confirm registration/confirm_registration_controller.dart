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
  SplashController(AuthenticationRepository authRepo,
      NavigationRepository navRepository, this._locationRepository)
      : _confirmRegistrationPresenter = ConfirmRegistrationPresenter(authRepo, navRepository) {}

  @override
  void initListeners() {
    // TODO: implement initListeners
  }
}
