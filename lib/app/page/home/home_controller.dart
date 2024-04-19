import './home_presenter.dart';
import '../../../domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;

class HomeController extends clean_architecture.Controller {
  bool isLoading = false;

  int _counter;
  User? _user;
  int get counter => _counter;
  User? get user => _user; // data used by the View

  late bool isLogout;

  final HomePresenter homePresenter;
  // Presenter should always be initialized this way
  HomeController(usersRepo, authRepo, navRepo)
      : _counter = 0,
        homePresenter = HomePresenter(usersRepo, authRepo, navRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
    homePresenter.getUserOnNext = _getUserOnNext;
    homePresenter.getUserOnComplete = _getUserOnComplete;
    // On error, show a snackbar, remove the user, and refresh the UI
    homePresenter.getUserOnError = _getUserOnError;

    homePresenter.logoutOnNext = _logoutOnNext;
    homePresenter.logoutOnComplete = _logoutOnComplete;
    homePresenter.logoutOnError = _logoutOnError;
  }

  void getUser() => homePresenter.getUser('test-uid');
  void getUserwithError() => homePresenter.getUser('test-uid231243');

  void logout() async {
    isLoading = true;

    refreshUI();

    Future.delayed(Duration(seconds: 2), () {
      homePresenter.logout();
    });
  }

  void goToLoginPage() {
    homePresenter.goToLoginPage(context: getContext());
  }

  void buttonPressed() {
    _counter++;
    refreshUI();
  }

  void _getUserOnComplete() {}

  void _getUserOnError(e) {
    print('Could not retrieve user.');
    ScaffoldMessenger.of(getContext())
        .showSnackBar(SnackBar(content: Text(e.message)));
    _user = null;
    refreshUI(); // Refreshes the UI manually
  }

  void _getUserOnNext(User user) {
    print(user.toString());
    _user = user;
    refreshUI(); // Refreshes the UI manually
  }

  void _logoutOnComplete() {
    print("logout retrieve");
  }

  void _logoutOnError(e) {
    print('Could not retrieve logout.');
    ScaffoldMessenger.of(getContext())
        .showSnackBar(SnackBar(content: Text(e.message)));
    _user = null;
  }

  void _logoutOnNext(bool status) {
    dismissLoading();

    if (status) {
      goToLoginPage();
    }
  }

  @override
  void onResumed() => print('On resumed');

  @override
  void onReassembled() => print('View is about to be reassembled');

  @override
  void onDeactivated() => print('View is about to be deactivated');

  @override
  void onDisposed() {
    homePresenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }
}
