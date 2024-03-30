import 'package:firebase_core/firebase_core.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/data/utils/constants.dart';
import 'package:rongchoi_app/data/utils/http_helper.dart';
import 'package:rongchoi_app/domain/entities/user.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rongchoi_app/firebase_options.dart';
import 'package:logging/logging.dart';

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

     try {
      // invoke http request to login and convert body to map
      await HttpHelper.invokeHttp("http://localhost:8080/v1/ready", RequestType.get);
      _logger.finest('Login Successful.');

   
    } catch(error) {
         Log.d("something bad happened runtimeType:", runtimeType);
      _logger.warning(error.toString());
      rethrow;
    }

    /*
    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Log.d(userCredential.toString(), runtimeType);
      Log.d("success login", runtimeType);
      _logger.finest('Login Successful.');
    } on FirebaseAuthException catch (ex) {
      Log.d("something bad happened runtimeType:ex.runtimeType", runtimeType);
      Log.d("$ex", runtimeType);

      _logger.warning(ex.message);
      rethrow;
    }
    */
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
