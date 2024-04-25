import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/shared/utils/language.dart';

class LanguageCubit extends Cubit<Language>{

  LanguageCubit() : super(Resources.languages[0]);

  void changeLanguage(Language language) => emit(language);

}