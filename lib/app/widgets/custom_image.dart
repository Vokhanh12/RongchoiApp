import 'package:rongchoi_app/app/page/home/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CustomImage extends StatelessWidget {
  final String url;
  const CustomImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // use a common controller assuming HomePageButton is always a child of Home
    return Image.asset(url, fit: BoxFit.contain);
  }
}
