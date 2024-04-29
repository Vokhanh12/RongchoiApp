import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/home%20with%20nav%20bar/home_with_nav_bar_presenter.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';

class HomeWithNavBarController extends clean_architecture.Controller {
  bool isLoading = false;
  int currentIndex = 0;

  final HomeWithNavBarPresenter _presenter;

  // Presenter should always be initialized this way
  HomeWithNavBarController(NavigationRepository navRepo)
      : _presenter = HomeWithNavBarPresenter(navRepo);

  @override
  void initListeners() {
    // TODO: implement initListeners

    _presenter.goToMediaSocialPageOnComplete = _goToMediaSocialOnComplete;
    _presenter.goToMediaSocialPageOnError = _goToMediaSocialOnError;
    _presenter.goToMediaSocialPageOnNext = _goToMediaSocialOnNext;

    _presenter.goToStorePageOnComplete = _goToStorePageOnComplete;
    _presenter.goToStorePageOnError = _goToStorePageOnError;
    _presenter.goToStorePageOnNext = _goToStorePageOnNext;

    _presenter.goToOtherTabInHomePageOnComplete =
        _goToOtherTabInHomePageOnComplete;
    _presenter.goToOtherTabInHomePageOnError = _goToOtherTabInHomePageOnError;
    _presenter.goToOtherTabInHomePageOnNext = _goToOtherTabInHomePageOnNext;
  }

  void _goToOtherTabInHomePageOnComplete() {}

  void _goToOtherTabInHomePageOnError(e) {}

  void _goToOtherTabInHomePageOnNext(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Store
        _goToMediaSocialPage(context);
        break;
      // Media social
      case 1:
        _goToStorePage(context);
        break;
      case 2:
        _goToJobsPage(context);
        break;
      case 3:
        _goToPersonalPage(context);
        break;
    }
  }

  void _goToMediaSocialPage(BuildContext context) {
    _presenter.goToMediaSocialPage(context);
  }

  void goToOtherTab(BuildContext context, int index) {
    _presenter.goToOtherTab(context, index);
  }

  void _goToJobsPage(BuildContext context) {
    _presenter.goToJobPage(context);
  }

  void _goToStorePage(BuildContext context) {
    _presenter.goToStorePage(context);
  }

  void _goToPersonalPage(BuildContext context) {
    _presenter.goToPersonal(context);
  }

  void _goToLanguagePage() {}

  void _goToSettingPage() {}

  void _goToStorePageOnComplete() {}

  void _goToStorePageOnError(e) {}

  void _goToStorePageOnNext(bool status) {}

  void _goToMediaSocialOnComplete() {}

  void _goToMediaSocialOnError(e) {}

  void _goToMediaSocialOnNext(bool status) {}
}
