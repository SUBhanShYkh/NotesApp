import 'package:flutter/material.dart';
import 'package:note_appv2/components/theme_data.dart';

class ThemeProvider with ChangeNotifier {
  // ... By Default _themeData Is lightMode
  ThemeData _themedata = lightMode;

  ThemeData get themedata => _themedata;
  bool get isDarkMode => _themedata == darkMode;
  set themeData(ThemeData themedata) {
    _themedata = themedata;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themedata == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
