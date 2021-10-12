import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences>? _sharedPreference;
  static const String isDarkMode = "is_dark_mode";
  static const String languageCode = "language_code";

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  //Theme module
  Future<bool> changeTheme(bool value) {
    return _sharedPreference!.then((prefs) {
      return prefs.setBool(isDarkMode, value);
    });
  }

  Future<bool> get isDarkModeOn {
    return _sharedPreference!.then((prefs) {
      return prefs.getBool(isDarkMode) ?? false;
    });
  }

  //Locale module
  Future<String>? get appLocale {
    return _sharedPreference?.then((prefs) {
      return prefs.getString(languageCode) ?? 'en';
    });
  }

  Future<bool> changeLanguage(String value) {
    return _sharedPreference!.then((prefs) {
      return prefs.setString(languageCode, value);
    });
  }
}
