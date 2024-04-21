import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rongchoi_app/app/page/register/form_cubit.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/data/utils/constants.dart';
import 'package:rongchoi_app/data/utils/http_helper.dart';
import 'package:rongchoi_app/domain/entities/form_register.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:rongchoi_app/firebase_options.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rongchoi_app/domain/entities/user.dart' as en;

class DataAuthenticationRepository extends AuthenticationRepository {
  // Variables
  late Logger _logger;

  late UserCredential _userCredential;

  // Convert string URL to Uri object
  final Uri _url = Uri.parse(Constants.loginRouter);

  // Members
  /// Singleton object of `DataAuthenticationRepository`
  static final DataAuthenticationRepository _instance =
      DataAuthenticationRepository._internal();

  // Constructors
  DataAuthenticationRepository._internal() {
    _logger = Logger('DataAuthenticationRepository');
  }

  factory DataAuthenticationRepository() => _instance;

  @override
  Future<void> authenticate({
    required String email,
    required String password,
  }) async {
    // handle firebase
    try {
      // Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Sign with email and password to Firebase
      _userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'test@gmail.com',
        password: 'Aa@123456789',
      );
      _logger.finest('Login firebase Successful.');
    } on FirebaseAuthException catch (ex) {
      _logger.warning(ex);
      rethrow;
    }

    // handle server
    try {
      // If user credentials are successful, then retrieve the token from Firebase.
      var token = await _userCredential.user!.getIdToken();
      Log.d("Bearer $token", runtimeType);

      Map<String, String> query = {
        'Authorization': 'Bearer $token',
      };

      // Invoke http request to login and convert body to map
      Map<String, dynamic> body = await HttpHelper.invokeHttp(
        _url,
        RequestType.get,
        headers: query,
      );

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
    throw UnimplementedError();
  }

  /// Returns whether the current `User` is authenticated.
  @override
  Future<bool> isAuthenticated() async {
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
  Future<bool> logout() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove(Constants.isAuthenticatedKey);
      _logger.finest('Logout successful.');
      return true;
    } catch (error) {
      _logger.warning('Could not log out.', error);
      return false;
    }
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
        preferences.setBool(
          Constants.isAuthenticatedKey,
          true,
        ),
        preferences.setString(
          Constants.userKey,
          jsonEncode(user),
        )
      ]);
      _logger.finest('Credentials successfully stored.');
    } catch (error) {
      _logger.warning('Credentials could not be stored. $error');
    }
  }

  @override
  Future<void> veritySMS({required int code}) {
    throw UnimplementedError();
  }

  @override
  Future<int> resendSMS() async {
    return 1233;
  }

  @override
  Future<FormRegister> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String rePassword,
      required String numberPhone}) async {
    try {
      // Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: "test2@gmail.com", password: "123456789");  
      _logger.finest('Register firebase Successful.');

      return FormRegister(firstName, lastName, email, password, rePassword, numberPhone);

    } on FirebaseAuthException catch (ex) {
      _logger.warning(ex);
      rethrow;
    }
  }
}
