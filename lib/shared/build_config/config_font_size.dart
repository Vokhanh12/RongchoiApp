class ConfigFontSize {
  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  double ratio = 0.0;

  // Private constructor
  ConfigFontSize._();

  // Instance of ScreenSize
  static final ConfigFontSize _instance = ConfigFontSize._();

  static double sizeForgotPasswordLabel = 0.0;
  static double sizeLoginTitle = 0.0;
  static double sizeOrLabel = 0.0;
  static double sizePasswordLabel = 0.0;
  static double sizeUsernameLabel = 0.0;
  static double sizeLoginButtonLabel = 0.0;
  static double sizeRegisterButtonLabel = 0.0;

  static double loginCheckEmailNotification = 0.0;
  static double loginAuthNotification = 0.0;
  static double loginHaveAccountLabel = 0.0;
  static double loginRegisterClickText = 0.0;

  static double registerLoginClickText = 0.0;
  static double registerHaveAccountLabel = 0.0;
  static double sizeRegisterTitle = 0.0;

  static double sizeLanguageSelectLabel = 0.0;

  // Method to initialize screen size
  static void init(double screenWidth, double screenHeight) {
    _instance._screenWidth = screenWidth;
    _instance._screenHeight = screenHeight;

    _instance.ratio = _instance._screenWidth / _instance._screenHeight;

    if (_instance._screenWidth >= 320 && _instance._screenWidth <= 413) {
      sizeForgotPasswordLabel = 5.0;
      sizeLoginTitle = 24.0;
      sizeOrLabel = 14.0;
      sizePasswordLabel = 17.0;
      sizeUsernameLabel = 17.0;
      sizeLoginButtonLabel = 16.0;
      sizeRegisterButtonLabel = 16.0;

      loginCheckEmailNotification = 0.0;
      loginAuthNotification = 0.0;
      loginHaveAccountLabel = 15.0;
      loginRegisterClickText = 15.0;

      registerLoginClickText = 15.0;
      registerHaveAccountLabel = 15.0;
       sizeRegisterTitle = 35.0;


      sizeLanguageSelectLabel = 20.0;
    } else if (_instance._screenWidth >= 360 && _instance._screenWidth <= 428) {
      sizeForgotPasswordLabel = 18.0;
      sizeLoginTitle = 22.0;
      sizeOrLabel = 18.0;
      sizePasswordLabel = 18.0;
      sizeUsernameLabel = 18.0;
      sizeLoginButtonLabel = 18.0;
      sizeRegisterButtonLabel = 18.0;
      sizeRegisterTitle = 35.0;

      loginCheckEmailNotification = 0.0;
      loginAuthNotification = 0.0;
      loginHaveAccountLabel = 14.0;
      loginRegisterClickText = 14.0;

      registerLoginClickText = 14.0;
      registerHaveAccountLabel = 14.0;


      sizeLanguageSelectLabel = 20.0;
    } else if (_instance._screenWidth >= 428 && _instance._screenWidth <= 768) {
      sizeForgotPasswordLabel = 18.0;
      sizeLoginTitle = 22.0;
      sizeOrLabel = 18.0;
      sizePasswordLabel = 18.0;
      sizeUsernameLabel = 18.0;
      sizeLoginButtonLabel = 18.0;
      sizeRegisterButtonLabel = 18.0;

      loginCheckEmailNotification = 0.0;
      loginAuthNotification = 0.0;
      loginHaveAccountLabel = 0.0;
      loginRegisterClickText = 0.0;
      registerLoginClickText = 0.0;
    }
  }
}
