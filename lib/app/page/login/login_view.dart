import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean_architecture;
import '../../../data/repositories/data_users_repository.dart';

class LoginPage extends clean_architecture.View {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  LoginPageState createState() =>
      // inject dependencies inwards
      LoginPageState();

}


class LoginPageState extends clean_architecture.ViewState<LoginPage, LoginController> {
  LoginPageState() : super(LoginController(DataUsersRepository()));

  @override
  Widget get view {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scaffold(
        key:
            globalKey, // built in global key for the ViewState for easy access in the controller
        body: Center(
         
          )
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}