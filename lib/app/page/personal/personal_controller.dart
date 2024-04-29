import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/personal/personal_presenter.dart';

class PersonalController extends clean_architecture.Controller {
  bool isLoading = false;

  final PersonalPresenter _personalPresenter;

  PersonalController(navRepo, authRepo)
      : _personalPresenter = PersonalPresenter(navRepo, authRepo),
        super();

  @override
  void initListeners() {
    // TODO: implement initListeners

    // Initialize [logout]
    _personalPresenter.logoutOnNext = _logoutOnNext;
    _personalPresenter.logoutOnComplete = _logoutOnComplete;
    _personalPresenter.logoutOnError = _logoutOnError;
  }

  void logout() async {
    isLoading = true;

    refreshUI();

    Future.delayed(Duration(seconds: 2), () {
      _personalPresenter.logout();
    });

    goToLoginPage();

  }

  void goToLoginPage() {
    _personalPresenter.goToLoginPage(context: getContext());
  }

  void _logoutOnComplete() {
    print("logout retrieve");
  }

  void _logoutOnError(e) {
    print('Could not retrieve logout.');
    ScaffoldMessenger.of(getContext())
        .showSnackBar(SnackBar(content: Text(e.message)));
    //_user = null;
  }

  void _logoutOnNext(bool status) {
    dismissLoading();

    if (status) {
      goToLoginPage();
    }
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }
}
