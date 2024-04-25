import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rongchoi_app/app/page/register/form_cubit.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/data/utils/constants.dart';
import 'package:rongchoi_app/data/utils/http_helper.dart';
import 'package:rongchoi_app/shared/utils/api.dart';
import 'package:rongchoi_app/shared/utils/form_register.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:rongchoi_app/firebase_options.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:rongchoi_app/domain/entities/user.dart' as entity;

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
    UserCredential? _userCredential;
    String? token;
    Map<String, String>? query; // Declare query here

    try {
      // Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Sign with email and password to Firebase
      _userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'test@gmail.com', // Use the parameter value
        password: '12345678', // Use the parameter value
      );
      _logger.finest('Login firebase Successful.');

      // Retrieve the token from Firebase after successful sign-in
      token = await _userCredential.user!.getIdToken();

      // Set the Authorization header for the HTTP request
      query = {
        'Authorization': 'Bearer $token', // Use the retrieved token
      };

      // Invoke http request to login and convert body to map
      var body = await HttpHelper.invokeHttp(
        _url,
        RequestType.get,
        headers: query,
      );

      // Parse response body into User, APIKey, and RefreshAPIKey objects
      entity.User user = entity.User.fromJson(body['user']);
      APIKey apiKey = APIKey.fromJson(body['api_key']);
      RefreshAPIKey refAPIKey = RefreshAPIKey.fromJson(body['refresh_api_key']);

      print(
          'getUser Successful. ${user.toJson()}'); // Use safe navigation operator
      print(
          'apiKey Successful. ${apiKey.toJson()}'); // Use safe navigation operator
      print(
          'refresh api key Successful. ${refAPIKey.toJson()}'); // Use safe navigation operator

      // Save user credentials
      _saveCredentials(
          email: email,
          password: password,
          user: user,
          token: token!,
          apiKey: apiKey,
          refAPIKey: refAPIKey);
    } catch (ex) {
      _logger.warning(ex);
      rethrow;
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
      FlutterSecureStorage sercureStorage = new FlutterSecureStorage();

      // delete the infomation
      sercureStorage.delete(key: Constants.token);
      sercureStorage.delete(key: Constants.email);
      sercureStorage.delete(key: Constants.password);
      sercureStorage.delete(key: Constants.apiKey);
      sercureStorage.delete(key: Constants.refAPIKey);
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
  Future<entity.User?> getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userJson = preferences.getString(Constants.userKey);
    if (userJson != null) {
      entity.User user = entity.User.fromJson(jsonDecode(userJson));
      return user;
    } else {
      // Trả về null hoặc xử lý tùy theo logic của ứng dụng
      return null;
    }
  }

  /// Saves the [token] and the [user] in `SharedPreferences`.
  void _saveCredentials(
      {required entity.User user,
      required String token,
      required APIKey apiKey,
      required RefreshAPIKey refAPIKey,
      required String email,
      required String password}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      FlutterSecureStorage sercureStorage = new FlutterSecureStorage();
      await Future.wait([
        preferences.setBool(
          Constants.isAuthenticatedKey,
          true,
        ),
        preferences.setString(
          Constants.userKey,
          jsonEncode(user),
        ),
        sercureStorage.write(key: Constants.token, value: token),
        sercureStorage.write(key: Constants.apiKey, value: jsonEncode(apiKey)),
        sercureStorage.write(
            key: Constants.refAPIKey, value: jsonEncode(refAPIKey)),
        sercureStorage.write(key: Constants.email, value: email),
        sercureStorage.write(key: Constants.password, value: password),
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
          .createUserWithEmailAndPassword(
              email: "test2@gmail.com", password: "123456789");
      _logger.finest('Register firebase Successful.');

      return FormRegister(
          firstName, lastName, email, password, rePassword, numberPhone);
    } on FirebaseAuthException catch (ex) {
      _logger.warning(ex);
      rethrow;
    }
  }
}
