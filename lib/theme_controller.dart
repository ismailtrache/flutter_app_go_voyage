import 'package:flutter/material.dart';

/// Simple singleton to share the selected theme across the app.
class ThemeController {
  ThemeController._();
  static final ThemeController instance = ThemeController._();

  final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  bool get isDark => themeMode.value == ThemeMode.dark;

  void setDark(bool enabled) {
    themeMode.value = enabled ? ThemeMode.dark : ThemeMode.light;
  }
}
