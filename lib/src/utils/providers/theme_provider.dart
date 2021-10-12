import 'package:flutter/material.dart';
import 'package:up_the_shelf/src/utils/helpers/shared_preference_helper.dart';

class ThemeProvider extends ChangeNotifier {
  // shared pref object
  late SharedPreferenceHelper _sharedPrefsHelper;

  bool _isDarkModeOn = false;

  ThemeProvider() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  bool get isDarkModeOn {
    _sharedPrefsHelper.isDarkModeOn.then((statusValue) {
      _isDarkModeOn = statusValue;
    });

    return _isDarkModeOn;
  }

  void updateTheme(bool isDarkModeOn) {
    _sharedPrefsHelper.changeTheme(isDarkModeOn);
    _sharedPrefsHelper.isDarkModeOn.then((darkModeStatus) {
      _isDarkModeOn = darkModeStatus;
    });

    notifyListeners();
  }
}
