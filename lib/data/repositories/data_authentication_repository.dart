import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/data/utils/constants.dart';
import 'package:rongchoi_app/data/utils/http_helper.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:rongchoi_app/firebase_options.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rongchoi_app/domain/entities/user.dart' as en;

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

    // Convert string URL to Uri object
    Uri url = Uri.parse("http://10.0.2.2:8080/v1/login");
    UserCredential userCredential;
    Map<String, dynamic> body;

    // handle firebase
    try {
      // Initialize Firebase
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      // Sign with email and password to Firebase
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'test@gmail.com', password: 'Aa@123456789');
      _logger.finest('Login firebase Successful.');
    } on FirebaseAuthException catch (ex) {
      Log.d("something bad happened runtimeType:ex.runtimeType", runtimeType);
      Log.d("$ex", runtimeType);

      _logger.warning(ex);
      rethrow;
    }

    // handle server
    try {
      // If user credentials are successful, then retrieve the token from Firebase.
      var token = await userCredential.user!.getIdToken();
      Log.d("Bearer $token", runtimeType);
      Map<String, String> query = {
        'Authorization': 'Bearer $token',
      };
      // Invoke http request to login and convert body to map
      body = await HttpHelper.invokeHttp(url, RequestType.get, headers: query);

      // en = entity package
      en.User user = en.User.fromJson(body['user']);
      print('getUser Successful. ${user.toJson()}');
      _saveCredentials(user: user);
    } catch (ex) {
      print('bug:$ex');
    }
  }

  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  /// Returns whether the current `User` is authenticated.
  @override
  Future<bool> isAuthenticated() async {
    // TODO: implement isAuthenticated
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool isAuthenticated =
          preferences.getBool(Constants.isAuthenticatedKey) ?? false;
      return isAuthenticated;
    } catch (error) {
      _logger.warning('Error fetching authentication status: $error');
      return false;
    }
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

  /// Returns the current authenticated `User` from `SharedPreferences`.
  @override
  Future<en.User?> getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userJson = preferences.getString(Constants.userKey);
    if (userJson != null) {
      en.User user = en.User.fromJson(jsonDecode(userJson));
      return user;
    } else {
      // Trả về null hoặc xử lý tùy theo logic của ứng dụng
      return null;
    }
  }

  /// Saves the [token] and the [user] in `SharedPreferences`.
  void _saveCredentials({required en.User user}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await Future.wait([
        preferences.setBool(Constants.isAuthenticatedKey, true),
        preferences.setString(Constants.userKey, jsonEncode(user))
      ]);
      _logger.finest('Credentials successfully stored.');
    } catch (error) {
      _logger.warning('Credentials could not be stored. $error');
    }
  }
}
