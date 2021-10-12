import 'package:flutter/material.dart';
import 'package:up_the_shelf/src/utils/helpers/shared_preference_helper.dart';

class LanguageProvider extends ChangeNotifier {
  // shared pref object
  late SharedPreferenceHelper _sharedPrefsHelper;

  Locale _appLocale = const Locale('en');

  LanguageProvider() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  Locale get appLocale {
    _sharedPrefsHelper.appLocale?.then((localeValue) {
      _appLocale = Locale(localeValue);
    });

    return _appLocale;
  }

  void updateLanguage(String languageCode) {
    _appLocale = Locale(languageCode);
    _sharedPrefsHelper.changeLanguage(languageCode);
    notifyListeners();
  }
}
