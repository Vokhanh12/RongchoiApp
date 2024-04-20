import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/register/form_cubit.dart';
import 'package:rongchoi_app/domain/entities/form_register.dart';
import 'package:rongchoi_app/app/page/register/register_presenter.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/register_usecase.dart';

class RegisterController extends clean_architecture.Controller {
  late final TextEditingController firstNameTextController;
  late final TextEditingController lastNameTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;
  late final TextEditingController rePasswordTextController;
  late final TextEditingController numberPhoneTextController;

  late bool isLoading;

  FormRegister? _formRegister;

  FormRegister? get getFormRegister => _formRegister;

  // Presenter
  final RegisterPresenter _registerPresenter;

  // Constructor

  RegisterController(
      AuthenticationRepository authRepo, NavigationRepository navRepository)
      : _registerPresenter = RegisterPresenter(authRepo, navRepository) {
    firstNameTextController = TextEditingController();
    lastNameTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    rePasswordTextController = TextEditingController();
    numberPhoneTextController = TextEditingController();

    isLoading = false;

    initListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    rePasswordTextController.dispose();
    numberPhoneTextController.dispose();

    super.dispose();
  }

  // Logs a [User] into the application
  void reigster() async {
    isLoading = true;
    refreshUI();
    // pass appropriate credentials here
    // assuming you have text fields to retrieve them and whatnot
    _registerPresenter.register(
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text,
        username: emailTextController.text,
        password: passwordTextController.text,
        rePassword: rePasswordTextController.text,
        numberPhone: numberPhoneTextController.text);
  }

  // Initializes [Presenter] listeners
  @override
  void initListeners() {
    // TODO: implement initListeners

    // Initialize presenter listeners here
    // These will be called upon success, failure, or data retrieval after usecase execution

    // Initialize [goToLanguagePage]
    _registerPresenter.goToLanguagePageOnComplete = _goToLanguagePageOnComplete;
    _registerPresenter.goToLanguagePageOnError = _goToLanguagePageOnError;

    // Initialize [goToLoginPage]
    _registerPresenter.goToLoginPageOnComplete = _goToLoginPageOnComplete;
    _registerPresenter.goToLoginPageOnError = _goToLoginPageOnError;

    // Initialize [register]
    _registerPresenter.registerOnComplete = _registerOnComplete;
    _registerPresenter.registerOnError = _registerOnError;
    _registerPresenter.registerOnNext = _registerOnNext;

    // Initialize [goToconRegisPage]
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

  void goToConRegisPage() {
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
    // save to use provider

    print(_formRegister!.numberPhone.toString());

    print("formRegister retrieve");

    getContext().read<FormRegisterCubit>().changeForm(_formRegister!);

      // Đợi 3 giây và sau đó hiển thị widget
    Future.delayed(Duration(seconds: 1), () {
         goToConRegisPage();
    });


  }

  void _registerOnNext(frmRegister) {
    _formRegister = frmRegister;

    refreshUI(); // Refreshes the UI manually

  }

  void _goToConRegisPageOnComplete() {
    dismissLoading();
  }

  void _goToConRegisPageOnError() {
    dismissLoading();
  }

  void _goToConRegisPageOnNext(String numberPhone) {}

  void _registerOnError(e) {
    // any cleaning or preparation goes here
    if (_registerPresenter.registerOnError != null) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
    }
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }
}
