import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/data/utils/constants.dart';
import 'package:rongchoi_app/data/utils/http_helper.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:rongchoi_app/firebase_options.dart';
import 'package:logging/logging.dart';

import '../../domain/entities/user.dart';

class DataAuthenticationRepository extends AuthenticationRepository {
  // Members
  /// Singleton object of `DataAuthenticationRepository`
  static DataAuthenticationRepository _instance =
      DataAuthenticationRepository._internal();

  late Logger _logger;

  // Constructors
  DataAuthenticationRepository._internal() {
    _logger = Logger('DataAuthenticationRepository');
  }

  factory DataAuthenticationRepository() => _instance;

  @override
  Future<void> authenticate(
      {required String email, required String password}) async {
    // TODO: implement authenticate

    /*
    try {
      // Convert string URL to Uri object
      Uri url = Uri.parse(Constants.loginRouter);

      // invoke http request to login and convert body to map
      Map<String, dynamic> body = await HttpHelper.invokeHttp(
          url, RequestType.post,
          body: {'email': email, 'password': password});

      _logger.finest('Login Successful.');

      // convert json to User and save credentials in local storage
      User user = User.fromJson(body);
    } catch (error) {
      _logger.warning(error.toString());

      rethrow;
    }
    */

    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: '', password: '');
      // Lấy token
      String? token = await userCredential.user!.getIdToken();
      print("Token: $token");
      Log.d(userCredential.toString(), runtimeType);
      Log.d("success login", runtimeType);
      _logger.finest('Login Successful.');
    } on FirebaseAuthException catch (ex) {
      Log.d("something bad happened runtimeType:ex.runtimeType", runtimeType);
      Log.d("$ex", runtimeType);

      _logger.warning(ex.message);
      rethrow;
    }
  }

  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> isAuthenticated() {
    // TODO: implement isAuthenticated
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register() {
    // TODO: implement register
    throw UnimplementedError();
  }
}
