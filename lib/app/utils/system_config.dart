import 'package:shared_preferences/shared_preferences.dart';

class SystemConfig {
  static final SystemConfig _instance = SystemConfig._internal();

  factory SystemConfig() {
    return _instance;
  }

  SystemConfig._internal();

  String _languageCode = 'vi';

  String get languageCode => _languageCode;

  set languageCode(String language) {
    _languageCode = language;
    _saveLanguageCode(language);
  }

  Future<void> _saveLanguageCode(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', language);
  }

  Future<void> loadLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString('languageCode') ?? 'vi';
  }
}