import 'package:flutter/material.dart';
import 'package:rongchoi_app/app/widgets/custom_svg_picture.dart';

class LanguageCard extends StatelessWidget {

  final String iconUrl;
  final String name;

  const LanguageCard({super.key, required this.iconUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSvgPicture(url: iconUrl, width: 100, height: 100),

          Padding(
              child: Text(name),
              padding: const EdgeInsets.only(left: 10, right: 10),
            ),
        ],
      ),
    );
  }




}