import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/login/login_presenter.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';

class LoginController extends clean_architecture.Controller {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late bool isLoading;

  final LoginPresenter _loginPresenter;

  LoginController(authRepo) : _loginPresenter = LoginPresenter(authRepo) {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    initListeners();
  }

  @override
  void initListeners() {
    // Initialize presenter listeners here
    // These will be called upon success, failure, or data retrieval after usecase execution
    _loginPresenter.loginOnComplete = () => print('Login Successful');
    _loginPresenter.loginOnError = (e) => print(e);
    _loginPresenter.loginOnNext = () => print("onNext");
  }

  void login() async {
    isLoading = true;
    refreshUI();
    // pass appropriate credentials here
    // assuming you have text fields to retrieve them and whatnot
    _loginPresenter.login(
        email: emailTextController.text, password: passwordTextController.text);
  }

  void register() {
    print("Clicked register");
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
