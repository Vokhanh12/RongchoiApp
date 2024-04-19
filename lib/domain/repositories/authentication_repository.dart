import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/entities/user.dart';

abstract class AuthenticationRepository {
  Future<void> authenticate({required String email, required String password});

  Future<void> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String repassword,
      required String numberPhone});

  /// Returns whether the [User] is authenticated.
  Future<bool> isAuthenticated();

  Future<void> forgotPassword(String email);

  /// Returns the current authenticated [User].
  Future<User?> getCurrentUser();

  Future<void> veritySMS({required int code});

  Future<int> resendSMS();

  Future<bool> logout();
}
