import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/login/login_presenter.dart';

class LoginController extends clean_architecture.Controller {
  late  String email;
  late  String password;

  final LoginPresenter presenter;

  LoginController(
      {required this.email,
      required this.password,
      required dynamic authenticationRepo})
      : presenter = LoginPresenter(authenticationRepo),
        super();

  @override
  void initListeners() {
    // Initialize presenter listeners here
    // These will be called upon success, failure, or data retrieval after usecase execution
    presenter.loginOnComplete = () => print('Login Successful');
    presenter.loginOnError = (e) => print(e);
    presenter.loginOnNext = () => print("onNext");
  }

  void login() {

    print(email);
    print(password);

    // pass appropriate credentials here
    // assuming you have text fields to retrieve them and whatnot
    presenter.login(email, password);
  }
}
