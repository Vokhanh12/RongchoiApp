import 'package:flutter/material.dart';
import 'package:rongchoi_app/domain/interface/screen_size_provider.dart';

class MediaQueryScreenSizeProvider implements ScreenSizeProvider {
  @override
  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  @override
  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}