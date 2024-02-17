import 'package:rongchoi_app/app/page/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCircleImage extends StatelessWidget {
  final String url;
  final Function() onTap;
 
  final double widthPicture;
  final double heightPicture;

  final Color color;

  const CustomCircleImage(
      {super.key,
      required this.url,
      required this.onTap,
  
      required this.color,
      required this.widthPicture,
      required this.heightPicture,
      });

  @override
  Widget build(BuildContext context) {

  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size..height;
    // use a common controller assuming HomePageButton is always a child of Home
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: this.color, // Background color
        ),
        child: Center(
          child: SvgPicture.asset(
            width: widthPicture,
            height: heightPicture,
            url,
            fit: BoxFit.contain,
            placeholderBuilder: (BuildContext context) =>
                CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
