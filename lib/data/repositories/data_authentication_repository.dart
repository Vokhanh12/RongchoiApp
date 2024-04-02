import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/data/utils/constants.dart';
import 'package:rongchoi_app/data/utils/http_helper.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:rongchoi_app/firebase_options.dart';
import 'package:logging/logging.dart';

import 'package:rongchoi_app/domain/entities/user.dart' as user_en;

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

    /*
    try {
      // Convert string URL to Uri object
      Uri url = Uri.parse(Constants.loginRouter);

      // invoke http request to login and convert body to map
      Map<String, dynamic> body = await HttpHelper.invokeHttp(
          url, RequestType.post,
          body: {'email': email, 'password': password});

      _logger.finest('Login Successful.');

      // convert json to User and save credentials in local storage
      User user = User.fromJson(body);
    } catch (error) {
      _logger.warning(error.toString());

      rethrow;
    }
    */
   // Convert string URL to Uri object
      Uri url = Uri.parse("http://10.0.2.2:8080/v1/login");

      Map<String, String> query = {
        'Authorization':
            'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImJhNjI1OTZmNTJmNTJlZDQ0MDQ5Mzk2YmU3ZGYzNGQyYzY0ZjQ1M2UiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcm9uZ2Nob2ktZTk2OTAiLCJhdWQiOiJyb25nY2hvaS1lOTY5MCIsImF1dGhfdGltZSI6MTcxMjA1NTExOCwidXNlcl9pZCI6IlZabjY2T3BFa2pNeXprSFNUbzJCcUNQWlU3RjMiLCJzdWIiOiJWWm42Nk9wRWtqTXl6a0hTVG8yQnFDUFpVN0YzIiwiaWF0IjoxNzEyMDU1MTE4LCJleHAiOjE3MTIwNTg3MTgsImVtYWlsIjoidGVzdEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsidGVzdEBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.06dGh7d8qavI2Msb7LewFvohvudewsJxSPuAx_pNBvSRv8LeDJvbUjmliZlQR-pJ9EmOlU1Td47B596lFkhZO_DnnkXHPtyR_H_TIT6r0QsnypNJgtpTCbsImsJ5Ca8nT1T_TcgeWT31xqmQlluG_nkZxaQsANRkPhaKyak_x_7dLO0kbaPNoJ9C-34EB5hsGEdjMOw9gomi0euxFrSoBybDbKA8PaKqFvdPsWvsfoLXL-iUZ4C0pAY_06qJP3eg-sMswxpv4SapbuWFDC1D9D9UaJ7gdPLYCLqShRvOE9BfbX_wxCKTnTkMXonf2N-hYbyYMToaZVlIfQcishnEag',
      };

    try {
      // Initialize Firebase
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      // Sign with email and password to Firebase
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: 'test@gmail.com', password: 'Aa@123456789');

      // If user credentials are successful, then retrieve the token from Firebase.
      String? token = await userCredential.user!.getIdToken();

      Log.d("Bearer $token ", runtimeType);

   
      // Invoke http request to login and convert body to map
      Map<String, dynamic> body =
          await HttpHelper.invokeHttp(url, RequestType.get, headers: query);

      user_en.User usera = user_en.User.fromJson(body);
      print('getUser Successful. ${usera.toJson()}');


      _logger.finest('Login Successful.');
    } on FirebaseAuthException catch (ex) {
      Log.d("something bad happened runtimeType:ex.runtimeType", runtimeType);
      Log.d("$ex", runtimeType);

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
