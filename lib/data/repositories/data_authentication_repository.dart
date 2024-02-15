import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';

class DataAuthenticationRepository extends AuthenticationRepository{

  @override
  Future<void> authenticate({required String email, required String password}) async {
    // TODO: implement authenticate
    print("hello world");
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