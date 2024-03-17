import 'package:firebase_core/firebase_core.dart';
import 'package:rongchoi_app/domain/entities/user.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rongchoi_app/firebase_options.dart';
import 'package:logging/logging.dart';

class DataAuthenticationRepository extends AuthenticationRepository {
  // Members
  /// Singleton object of `DataAuthenticationRepository`
  static DataAuthenticationRepository _instance = DataAuthenticationRepository._internal();

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
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      print("email:" + email);
      print("password:" + password);
      print("success login");
      _logger.finest('Login Successful.');
    } on FirebaseAuthException catch (ex) {
      print("email:" + email);
      print("password:" + password);

      print("something bad happened");
      print(ex.runtimeType);
      print(ex);

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
