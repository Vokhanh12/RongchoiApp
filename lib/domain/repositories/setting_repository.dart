
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class SettingRepository{

 Future<void> changeLanguage({required BuildContext context,required String code});

  // more .....

}