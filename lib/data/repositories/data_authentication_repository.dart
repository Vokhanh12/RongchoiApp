import 'package:firebase_core/firebase_core.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rongchoi_app/firebase_options.dart';

class DataAuthenticationRepository extends AuthenticationRepository {
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
    } on FirebaseAuthException catch (ex) {
      print("email:" + email);
      print("password:" + password);

      print("something bad happened");
      print(ex.runtimeType);
      print(ex);
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
