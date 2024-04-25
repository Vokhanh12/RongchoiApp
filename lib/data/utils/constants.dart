import 'package:flutter/material.dart';
import 'package:rongchoi_app/app/widgets/scaffold_with_nav_bar.dart';
import 'package:rongchoi_app/app/widgets/custom_bottom_nav_bar_item.dart';
import 'package:rongchoi_app/shared/utils/api.dart';

class Constants {
  // APIs
  static const String baseUrl = 'http://$baseUrlNoPrefix';
  static const String loginRouter = '$baseUrl/v1/login';

 

  // APIs no prefix
  static const String baseUrlNoPrefix = '10.0.2.2:8080';

  // Local Storage
  static const String email = "email";
  static const String password = "password";
  static const String token = 'authentication_token';
  static const String apiKey = 'api_key';
  static const String refAPIKey = 'refresh_api_key';
  static const String userKey = 'user_key';
  static const String isAuthenticatedKey = 'isUserAuthenticated';
}
