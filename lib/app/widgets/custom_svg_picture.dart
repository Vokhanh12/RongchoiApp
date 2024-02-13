import 'package:rongchoi_app/app/page/home/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgPicture extends StatelessWidget {
  final String url;
  final double? width, height;

  const CustomSvgPicture({super.key, required this.url, required this.width,required this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      url,
      width: width,
      height: height,
      fit: BoxFit.contain
    );
  }
}
