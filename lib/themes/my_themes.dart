import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

enum MyThemeKeys { LIGHT, DARK }

class MyThemes {
  static final ThemeData ligh = lightTheme();
  static final ThemeData dark = darkTheme();

  static MyThemeKeys geKey(String key) {
    //print(MyThemeKeys.LIGHT.toString().split('.').last);
    if (key == MyThemeKeys.LIGHT.toString()) {
      return MyThemeKeys.LIGHT;
    } else if (key == MyThemeKeys.DARK.toString()) {
      return MyThemeKeys.DARK;
    }
    return MyThemeKeys.LIGHT;
  }

  static ThemeData getThemeFromKey(MyThemeKeys key) {
    switch(key) {
      case MyThemeKeys.LIGHT: return ligh;
      case MyThemeKeys.DARK: return dark;
      default: return ligh;
    }
  }

}