
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rongchoi_app/shared/utils/language.dart';

abstract class SettingRepository{

 Future<void> changeLanguage(BuildContext context,Language language);

  // more .....

}