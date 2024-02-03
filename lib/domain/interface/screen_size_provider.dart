import 'package:flutter/material.dart';

abstract class ScreenSizeProvider {
  double getScreenWidth(BuildContext context);
  double getScreenHeight(BuildContext context);
}
