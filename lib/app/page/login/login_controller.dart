import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/login/login_presenter.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';

class LoginController extends clean_architecture.Controller {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  bool isLoading = false;

  final LoginPresenter _loginPresenter;

  LoginController(authRepo) : _loginPresenter = LoginPresenter(authRepo) {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    initListeners();
  }


   /// Initializes [Presenter] listeners
  @override
  void initListeners() {
    // Initialize presenter listeners here
    // These will be called upon success, failure, or data retrieval after usecase execution
    _loginPresenter.loginOnComplete = _loginOnComplete;
    _loginPresenter.loginOnError = _loginOnError;
  }


  // Logs a [User] into the application
  void login() async {
    isLoading = true;
    refreshUI();
    // pass appropriate credentials here
    // assuming you have text fields to retrieve them and whatnot
    _loginPresenter.login(
        email: emailTextController.text, password: passwordTextController.text);
  }

  /// Login is successful
  void _loginOnComplete() {
    dismissLoading();
    showGenericSnackbar(getContext(), "Đăng nhập thành công", isError: false);
  }

  void _loginOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: true);
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  void _submit() async {
    isLoading = true;

    print("Submitting to backend ...");
  }

  void register() {
    print("Clicked register");
    showGenericSnackbar(getContext(), "Hello world", isError: false);
  }

  void forgotPassword() {
    print("Clicked forgot password");
  }

  void loginWithGoogle() {
    print("Clicked login with google");
  }

  void loginWithFacebook() {
    print("Clicked login with facebook");
  }
}
