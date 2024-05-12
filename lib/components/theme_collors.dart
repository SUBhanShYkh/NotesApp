import 'package:flutter/material.dart';

class UiColors {
  static Color bg(BuildContext context) {
    return Theme.of(context).colorScheme.background;
  }

  static Color pm(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color sec(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color inpm(BuildContext context) {
    return Theme.of(context).colorScheme.inversePrimary;
  }
}
