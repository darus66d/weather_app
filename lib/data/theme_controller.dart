import 'package:flutter/material.dart';

class MyTheme {
  static ValueNotifier<ThemeMode> currentTheme =
  ValueNotifier(ThemeMode.system);

  static void setLight() => currentTheme.value = ThemeMode.light;
  static void setDark() => currentTheme.value = ThemeMode.dark;
  static void setSystem() => currentTheme.value = ThemeMode.system;
}
