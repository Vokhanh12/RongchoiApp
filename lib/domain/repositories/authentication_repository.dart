import 'package:flutter/material.dart';

abstract class AuthenticationRepository{

  Future<void> authenticate(
      {required String email, required String password});

  Future<void> register();

  Future<bool> isAuthenticated();

  Future<void> forgotPassword(String email);

  Future<void> logout();

}