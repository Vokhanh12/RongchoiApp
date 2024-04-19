import 'dart:js';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/register/register_presenter.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/register_usecase.dart';

class RegisterController extends clean_architecture.Controller {
  bool isLoading = false;

  // Presenter
  final RegisterPresenter _registerPresenter;

  // Constructor

  RegisterController(
      AuthenticationRepository authRepo, NavigationRepository navRepository)
      : _registerPresenter = RegisterPresenter(authRepo, navRepository) {
    initListeners();
  }

  // Logs a [User] into the application
  void reigster() async {
    isLoading = true;
    refreshUI();
    // pass appropriate credentials here
    // assuming you have text fields to retrieve them and whatnot
    _registerPresenter.register(
        firstName: '',
        lastName: '',
        username: '',
        password: '',
        rePassword: '',
        numberPhone: '');
  }

  // Initializes [Presenter] listeners
  @override
  void initListeners() {
    // TODO: implement initListeners

    // Initialize presenter listeners here
    // These will be called upon success, failure, or data retrieval after usecase execution

    _registerPresenter.goToLanguagePageOnComplete = _goToLanguagePageOnComplete;
    _registerPresenter.goToLanguagePageOnError = _goToLanguagePageOnError;

    _registerPresenter.goToLoginPageOnComplete = _goToLoginPageOnComplete;
    _registerPresenter.goToLoginPageOnError = _goToLoginPageOnError;

    _registerPresenter.registerOnComplete = _registerOnComplete;
    _registerPresenter.registerOnError = _registerOnError;
    _registerPresenter.registerOnNext = _registerOnNext;

    _registerPresenter.goToConRegisPageOnComplete = _goToConRegisPageOnComplete;
    _registerPresenter.goToConRegisPageOnError = _goToConRegisPageOnError;
    _registerPresenter.goToConRegisPageOnNext = _goToConRegisPageOnNext;
  }

  // Navigate to login page
  void goToLoginPage() {
    _registerPresenter.goToLoginPage(context: getContext());
  }

  // Navigate to login page
  void goToLanguagePage() {
    _registerPresenter.goToLanguagePage(context: getContext());
  }

  void goToConRegisPage(){
    _registerPresenter.goToConRegisPage(context: getContext());
  }

  /// Navigate is successful
  void _goToLoginPageOnComplete() {
    dismissLoading();
  }

  /// Navigate is error
  void _goToLoginPageOnError(e) {
    dismissLoading();
  }

  /// Navigate is successful
  void _goToLanguagePageOnComplete() {
    dismissLoading();
  }

  /// Navigate is error
  void _goToLanguagePageOnError(e) {
    dismissLoading();
  }

  void _registerOnComplete() {
    dismissLoading();

    goToConRegisPage();

  }

  void _goToConRegisPageOnComplete() {
    dismissLoading();
  }

  void _goToConRegisPageOnError() {
    dismissLoading();
  }

  void _goToConRegisPageOnNext(String numberPhone) {

    

  }

  void _registerOnError(e) {
    // any cleaning or preparation goes here
    if (_registerPresenter.registerOnError != null) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
    }
  }

  void _registerOnNext() {}

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }
}
