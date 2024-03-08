// Singleton class for storing screen size

import 'package:flutter/widgets.dart';

class ScreenSize {
  static late double screenWidth;
  static late double screenHeight;

  // Private constructor
  ScreenSize._();

  // Instance of ScreenSize
  static final ScreenSize _instance = ScreenSize._();

  // Factory constructor to return the same instance
  factory ScreenSize() {
    return _instance;
  }

  // Method to initialize screen size
  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
