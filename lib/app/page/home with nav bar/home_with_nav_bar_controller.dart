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
  int _currentIndex = 0;

  final HomeWithNavBarPresenter _homeWithNavBarPresenter;

  // Presenter should always be initialized this way
  HomeWithNavBarController(NavigationRepository navRepo)
      : _homeWithNavBarPresenter = HomeWithNavBarPresenter(navRepo);

  @override
  void initListeners() {
    // TODO: implement initListeners

    _homeWithNavBarPresenter.goToMediaSocialPageOnComplete =
        _goToMediaSocialOnComplete;
    _homeWithNavBarPresenter.goToMediaSocialPageOnError =
        _goToMediaSocialOnError;
    _homeWithNavBarPresenter.goToMediaSocialPageOnNext = _goToMediaSocialOnNext;

    _homeWithNavBarPresenter.goToStorePageOnComplete = _goToStorePageOnComplete;
    _homeWithNavBarPresenter.goToStorePageOnError = _goToStorePageOnError;
    _homeWithNavBarPresenter.goToStorePageOnNext = _goToStorePageOnNext;

    _homeWithNavBarPresenter.goToOtherTabInHomePageOnComplete =
        _goToOtherTabInHomePageOnComplete;
    _homeWithNavBarPresenter.goToOtherTabInHomePageOnError =
        _goToOtherTabInHomePageOnError;
    _homeWithNavBarPresenter.goToOtherTabInHomePageOnNext =
        _goToOtherTabInHomePageOnNext;
  }


  void _goToOtherTabInHomePageOnComplete() {}

  void _goToOtherTabInHomePageOnError(e) {}

  void _goToOtherTabInHomePageOnNext(BuildContext context, int index) {

    switch (index) {
      case 0:
        // Store
        _goToStorePage(context: context);
        break;

      // Media social
      case 1:
        _goToMediaSocialPage(context: context);
        break;
    }
  }

    void goToOtherTab({required BuildContext context, required int index}) {
    _homeWithNavBarPresenter.goToOtherTab(context, index);
  }


  void _goToJobsPage({required BuildContext context}) {}

  void _goToStorePage({required BuildContext context}) {
    _homeWithNavBarPresenter.goToStorePage(context);
  }

  void _goToMediaSocialPage({required BuildContext context}) {
    _homeWithNavBarPresenter.goToMediaSocialPage(context);
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
