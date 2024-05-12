import 'package:flutter/material.dart';

// ... LIGHT MODE THEME DATA
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.blueGrey.shade300,
    primary: Colors.blueGrey.shade200,
    secondary: Colors.blueGrey.shade400,
    inversePrimary: Colors.blueGrey.shade800,
  ),
);
// ... DARK MODE THEME DATA
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.blueGrey.shade900,
    primary: Colors.blueGrey.shade800,
    secondary: Colors.blueGrey.shade700,
    inversePrimary: Colors.blueGrey.shade300,
  ),
);
