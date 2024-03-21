
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rongchoi_app/domain/entities/language.dart';

abstract class SettingRepository{

 Future<void> changeLanguage(BuildContext context,Language language);

  // more .....

}