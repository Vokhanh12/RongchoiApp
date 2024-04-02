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

    // Convert string URL to Uri object
    Uri url = Uri.parse("http://10.0.2.2:8080/v1/login");
    UserCredential userCredential;
    Map<String, dynamic> body;
    try {
      // Initialize Firebase
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      // Sign with email and password to Firebase
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'test@gmail.com', password: 'Aa@123456789');
      _logger.finest('Login Successful.');
    } on FirebaseAuthException catch (ex) {
      Log.d("something bad happened runtimeType:ex.runtimeType", runtimeType);
      Log.d("$ex", runtimeType);

      _logger.warning(ex);
      rethrow;
    }

    try {
      // If user credentials are successful, then retrieve the token from Firebase.
      var token = await userCredential.user!.getIdToken();

      Log.d("Bearer $token ", runtimeType);

      Map<String, String> query = {
        'Authorization':
            'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImJhNjI1OTZmNTJmNTJlZDQ0MDQ5Mzk2YmU3ZGYzNGQyYzY0ZjQ1M2UiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcm9uZ2Nob2ktZTk2OTAiLCJhdWQiOiJyb25nY2hvaS1lOTY5MCIsImF1dGhfdGltZSI6MTcxMjA2NDA2NiwidXNlcl9pZCI6IlZabjY2T3BFa2pNeXprSFNUbzJCcUNQWlU3RjMiLCJzdWIiOiJWWm42Nk9wRWtqTXl6a0hTVG8yQnFDUFpVN0YzIiwiaWF0IjoxNzEyMDY0MDY2LCJleHAiOjE3MTIwNjc2NjYsImVtYWlsIjoidGVzdEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsidGVzdEBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.F3ypgu83NMkEJtmqzCYPGsTbHBw60YgV0LPe0j2dBaOPAP_yICtMCQuqRyoQQjO8sjbwninteeflEG_RGEvNUl9RVMz0kJ-FsNC12K90V9ObqM0gvhJHh1jeJ9lWz3KSjjSRrFIYZypawNbqErSOR77ArYTru5ubq3ynoJKmOiuugQVsT_HAIoXHFVioJR0xciaf1lLk-Tx2Kx5qVP1Haw9avCTOJ5ro8QyDtSMoA9QZ0gFqMeCzk2iP9GGUfrrjrPqLtd9GqoPdF9AxNzjUCgGrxMGjvwksICkgBVWXuJkYyqOhQC_4tzejvR4ZPkXwRchf902oDG54OKUDntWZJA',
      };
      print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
      // Invoke http request to login and convert body to map
      try {
        print("query:" + query.toString());
        print("url:" + url.toString());
        body =
            await HttpHelper.invokeHttp(url, RequestType.get, headers: query);
        user_en.User user = user_en.User.fromJson(body);
        print(user.toJson());
      } catch (e) {
        print('Xảy ra lỗi khi gọi API: $e');
      }
    } catch (ex) {
      print('bug:$ex');
    }

    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
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
