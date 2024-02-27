import 'package:rongchoi_app/domain/entities/language.dart';

abstract class LanguageEvent {
  const LanguageEvent();
}

class ToggleLanguageEvent extends LanguageEvent {
  final Language language;

  ToggleLanguageEvent(this.language);
}