import './home_presenter.dart';
import '../../../domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;

class HomeController extends clean_architecture.Controller {
  late int currentIndex;

  bool isLoading = false;

  int _counter;
  User? _user;
  int get counter => _counter;
  User? get user => _user; // data used by the View

  late bool isLogout;

  final HomePresenter _homePresenter;
  // Presenter should always be initialized this way
  HomeController(usersRepo, authRepo, navRepo)
      : _counter = 0,
        _homePresenter = HomePresenter(usersRepo, authRepo, navRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
    // Initialize [getUser]
    _homePresenter.getUserOnNext = _getUserOnNext;
    _homePresenter.getUserOnComplete = _getUserOnComplete;
    _homePresenter.getUserOnError = _getUserOnError;

  }

  void getUser() => _homePresenter.getUser('test-uid');
  void getUserwithError() => _homePresenter.getUser('test-uid231243');


  void buttonPressed() {
    _counter++;
    refreshUI();
  }

  @override
  void onResumed() => print('On resumed');

  @override
  void onReassembled() => print('View is about to be reassembled');

  @override
  void onDeactivated() => print('View is about to be deactivated');

  @override
  void onDisposed() {
    _homePresenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }

  void dismissLoading() {
    isLoading = false;
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

}
