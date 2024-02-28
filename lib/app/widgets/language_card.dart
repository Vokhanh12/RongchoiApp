import 'package:flutter/material.dart';
import 'package:rongchoi_app/app/widgets/custom_svg_picture.dart';

class LanguageCard extends StatelessWidget {
  final String iconUrl;
  final String name;
  final Function() onTap;

  const LanguageCard({super.key, required this.iconUrl, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.only(
            left: 5.0,
            right: 5.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSvgPicture(url: iconUrl, width: 80, height: 80),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 17.0, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
