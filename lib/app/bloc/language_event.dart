abstract class LanguageEvent {}



class changeLanguageVietnamese extends LanguageEvent{

  changeLanguageVietnamese(this.type){
    print("change tieng viet");
  }

  final String type;

}



class changeLanguageEnglish extends LanguageEvent{

  changeLanguageEnglish(this.type){
    print("change english");
  }

  final String type;

}