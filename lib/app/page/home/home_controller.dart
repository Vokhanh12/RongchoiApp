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

    // Initialize [logout]
    _homePresenter.logoutOnNext = _logoutOnNext;
    _homePresenter.logoutOnComplete = _logoutOnComplete;
    _homePresenter.logoutOnError = _logoutOnError;

    // Initialize [goToOtherTab]
    _homePresenter.goToOtherTabInHomePageOnComplete =
        _goToOtherTabInHomePageOnComplete;
    _homePresenter.goToOtherTabInHomePageOnError =
        _goToOtherTabInHomePageOnError;
    _homePresenter.goToOtherTabInHomePageOnNext = _goToOtherTabInHomePageOnNext;

    // Initialize [goToMediaSocial]
    _homePresenter.goToMediaSocialPageOnComplete = _goToMediaSocialOnComplete;
    _homePresenter.goToMediaSocialPageOnError = _goToMediaSocialOnError;
    _homePresenter.goToMediaSocialPageOnNext = _goToMediaSocialOnNext;

    // Initialize [goToStore]
    _homePresenter.goToStorePageOnComplete = _goToStorePageOnComplete;
    _homePresenter.goToStorePageOnError = _goToStorePageOnError;
    _homePresenter.goToStorePageOnNext = _goToStorePageOnNext;

    // Initialize [goToPersonalPage]
    _homePresenter.goToPersonalPageOnComplete = _goToPersonalPageOnComplete;
    _homePresenter.goToPersonalPageOnError = _goToPersonalPageOnError;
    _homePresenter.goToPersonalPageOnNext = _goToPersonalPageOnNext;

    // Initialize [goToJobPage]
    _homePresenter.goToJobPageOnComplete = _goToJobPageOnComplete;
    _homePresenter.goToJobPageOnError = _goToJobPageOnError;
    _homePresenter.goToJobPageOnNext = _goToJobPageOnNext;
  }

  void getUser() => _homePresenter.getUser('test-uid');
  void getUserwithError() => _homePresenter.getUser('test-uid231243');

  void logout() async {
    isLoading = true;

    refreshUI();

    Future.delayed(Duration(seconds: 2), () {
      _homePresenter.logout();
    });
  }

  void goToLoginPage() {
    _homePresenter.goToLoginPage(context: getContext());
  }

  void _goToJobsPage(BuildContext context) {
    _homePresenter.goToJobPage(context);
  }

  void _goToStorePage(BuildContext context) {
    _homePresenter.goToStorePage(context);
  }

  void _goToPersonalPage(BuildContext context) {
    _homePresenter.goToPersonal(context);
  }

  void goToOtherTab({required BuildContext context, required int index}) {
    _homePresenter.goToOtherTab(context, index);
  }

  void _goToOtherTabInHomePageOnComplete() {}

  void _goToOtherTabInHomePageOnError(e) {}

  void _goToOtherTabInHomePageOnNext(BuildContext context, int index) async {
    // Make sure the language has been completely changed before displaying the message

 // Update currentIndex before navigating
  currentIndex = index;

  print("Test: $currentIndex");


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
    _homePresenter.goToMediaSocialPage(context);
  }

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

  void _goToLanguagePage() {}

  void _goToSettingPage() {}

  void _goToStorePageOnComplete() {}

  void _goToStorePageOnError(e) {}

  void _goToStorePageOnNext(bool status) {}

  void _goToMediaSocialOnComplete() {}

  void _goToMediaSocialOnError(e) {}

  void _goToMediaSocialOnNext(bool status) {}

  void _goToPersonalPageOnComplete() {}

  void _goToPersonalPageOnError(e) {}

  void _goToPersonalPageOnNext(bool status) {}

  void _goToJobPageOnComplete() {}

  void _goToJobPageOnError(e) {}

  void _goToJobPageOnNext(bool status) {}
}
