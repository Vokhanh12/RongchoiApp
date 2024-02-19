import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataAuthenticationRepository extends AuthenticationRepository {
  @override
  Future<void> authenticate(
      {required String email, required String password}) async {
    // TODO: implement authenticate

    try {
      final userCerdential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          print(userCerdential);
          print("success login");
    } on FirebaseAuthException catch (ex) {

      print("email:"+ email);
      print("password:"+ password);

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
