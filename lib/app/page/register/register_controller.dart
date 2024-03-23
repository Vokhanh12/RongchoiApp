import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/register/register_presenter.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/register_usecase.dart';

class RegisterController extends clean_architecture.Controller {
  bool isLoading = false;

  // Presenter
  final RegisterPresenter _registerPresenter;

  // Constructor

  RegisterController(AuthenticationRepository authRepo)
      : _registerPresenter = RegisterPresenter(authRepo) {
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
  }


  // Navigate to login page
  void goToLoginPage(){
    
  }

}
