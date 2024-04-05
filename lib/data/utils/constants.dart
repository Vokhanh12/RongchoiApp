class Constants {
  // APIs
  static const String baseUrl = 'http://$baseUrlNoPrefix';
  static const String loginRouter = '$baseUrl/login';

  // APIs no prefix
  static const String baseUrlNoPrefix = '10.0.2.2:8080';

  // Local Storage
  static const String apiKey = 'authentication_token';
  static const String userKey = 'user_key';
  static const String isAuthenticatedKey = 'isUserAuthenticated';
}
