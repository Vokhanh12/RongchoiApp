class ScreenConfig {
  double _screenWidth = 0.0;
  double _screenHeigth = 0.0;

  double ratio = 0.0;

// region Login page

  //size

  //ratio

  static double sizeForgotPasswordLabel = 0.0;
  static double sizeLoginTitle = 0.0;
  static double sizeOrLabel = 0.0;
  static double sizePasswordLabel = 0.0;
  static double sizeUsernameLabel = 0.0;
  static double sizeLoginButtonLabel = 0.0;
  static double sizeRegisterButtonLabel = 0.0;

// endregion Login page

// regRegister page

  //size

  //ratio

// endregion Register page

  // Register page

  // ....

  ScreenConfig(double screenWidth, double screenHeigth) {
    _screenWidth = screenWidth;
    _screenHeigth = screenHeigth;

    if (_screenWidth >= 320 && _screenWidth <= 413) {
      sizeForgotPasswordLabel = 0.0;
      sizeLoginTitle = 24.0;
      sizeOrLabel = 14.0;
      sizePasswordLabel = 17.0;
      sizeUsernameLabel = 17.0;
      sizeLoginButtonLabel = 16.0;
      sizeRegisterButtonLabel = 16.0;
    } else if (_screenWidth >= 360 && _screenWidth <= 428) {
      sizeForgotPasswordLabel = 18.0;
      sizeLoginTitle = 22.0;
      sizeOrLabel = 18.0;
      sizePasswordLabel = 18.0;
      sizeUsernameLabel = 18.0;
      sizeLoginButtonLabel = 18.0;
      sizeRegisterButtonLabel = 18.0;
    } else if (_screenWidth >= 428 && _screenWidth <= 768) {
      sizeForgotPasswordLabel = 0.0;
      sizeLoginTitle = 24.0;
      sizeOrLabel = 0.0;
      sizePasswordLabel = 0.0;
      sizeUsernameLabel = 0.0;
      sizeLoginButtonLabel = 0.0;
      sizeRegisterButtonLabel = 0.0;
    }
  }
}
