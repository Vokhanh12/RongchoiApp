import 'package:rongchoi_app/app/page/home/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCircleImage extends StatelessWidget {
  final String url;
  final Function() onTap;
  const CustomCircleImage({super.key, required this.url, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // use a common controller assuming HomePageButton is always a child of Home
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        constraints: BoxConstraints(
          maxWidth: 200,
          maxHeight: 200, // Set the maximum height
        ),
        child: SvgPicture.asset(
          url,
          fit: BoxFit.contain,
          placeholderBuilder: (BuildContext context) =>
              const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
