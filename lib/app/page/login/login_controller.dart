import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/login/login_presenter.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/data/utils/http_helper.dart';
import 'package:rongchoi_app/domain/entities/user.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';

class LoginController extends clean_architecture.Controller {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  bool isLoading = false;

  // Presenter
  final LoginPresenter _loginPresenter;

  // Construstor
  LoginController(authRepo, navRepository)
      : _loginPresenter = LoginPresenter(authRepo, navRepository) {
    // email used to for textfield
    emailTextController = TextEditingController();
    // password used to for textfield
    passwordTextController = TextEditingController();
    initListeners();
  }

  /// Initializes [Presenter] listeners
  @override
  void initListeners() {
    // Initialize presenter listeners here
    // These will be called upon success, failure, or data retrieval after usecase execution

    // Initialize [login]
    _loginPresenter.loginOnComplete = _loginOnComplete;
    _loginPresenter.loginOnError = _loginOnError;

    // Initialize [goToRegisterPage]
    _loginPresenter.goToRegisterPageOnComplete = _goToRegisterPageOnComplete;
    _loginPresenter.goToRegisterPageOnError = _goToRegisterPageOnError;

    // Initialize [goToLanguagePage]
    _loginPresenter.goToLanguagePageOnComplete = _goToLanguagePageOnComplete;
    _loginPresenter.goToLanguagePageOnError = _goToLanguagePageOnError;

    // Initialize [goToHomePage]
    _loginPresenter.goToHomePageOnComplete = _goToHomePageOnComplete;
    _loginPresenter.goToHomePageOnError = _goToHomePageOnError;
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
    _loginPresenter.goToHomePage(context: getContext());
  }

  /// Login is error
  void _loginOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: true);
  }

  /// go to RegisterPage is successful
  void _goToRegisterPageOnComplete() {
    dismissLoading();
  }

  /// go to RegisterPage is error
  void _goToRegisterPageOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: true);
  }

  /// go to LanguagePage is successful
  void _goToLanguagePageOnComplete() {
    dismissLoading();
  }

  /// go to LanguagePage is error
  void _goToLanguagePageOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: true);
  }

  /// go to HomePage is successful
  void _goToHomePageOnComplete() {
    dismissLoading();
  }

  /// go to LanguagePage is error
  void _goToHomePageOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: true);
  }

  // Logs a [User] into the application
  void _submit() async {
    isLoading = true;

    print("Submitting to backend ...");
  }

  // Logs a [User] into the application
  void goToRegisterPage() {
    // Go to RegisterPage
    _loginPresenter.goToRegisterPage(context: getContext());
  }

  // Logs a [User] into the application
  void goToLanguagePage() {
    // Go to RegisterPage
    _loginPresenter.goToLanguagePage(context: getContext());
  }

  // Logs a [User] into the application
  void forgotPassword() {
    print("Clicked forgot password");
  }

  // Logs a [User] into the application
  void loginWithGoogle() async {
    print("Clicked login with google");

    Map<String, String> query = {
      'Authorization':
          'ApiKey 01b94fca0e4d7db88204f617cd5f5a77012239fbfb1f3f8e968b815bc0978f55',
    };

    try {
      // Convert string URL to Uri object
      Uri url = Uri.parse("http://10.0.2.2:8080/v1/users");

      // Invoke http request to login and convert body to map
      Map<String, dynamic> body =
          await HttpHelper.invokeHttp(url, RequestType.get, headers: query);

      User user = User.fromJson(body);
      print('getUser Successful. ${user.toJson()}');
    } catch (error) {
      print(error);
    }
  }

  // Logs a [User] into the application
  void loginWithFacebook() {
    print("Clicked login with facebook");
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }
}
