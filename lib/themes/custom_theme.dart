import '../utils/preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dark_theme.dart';
import 'my_themes.dart';

class _CustomTheme extends InheritedWidget {
  final CustomThemeState data;

  _CustomTheme({
    this.data,
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_CustomTheme oldWidget) {
    return true;
  }
}

class CustomTheme extends StatefulWidget {
  final Widget child;
  final MyThemeKeys initialThemeKey;

  const CustomTheme({
    Key key,
    this.initialThemeKey,
    @required this.child,
  }) : super(key: key);

  @override
  CustomThemeState createState() => new CustomThemeState();

  static ThemeData of(BuildContext context) {
    _CustomTheme inherited = (context.dependOnInheritedWidgetOfExactType<_CustomTheme>());
    return inherited.data.theme;
  }

  static CustomThemeState instanceOf(BuildContext context) {
    _CustomTheme inherited = (context.dependOnInheritedWidgetOfExactType<_CustomTheme>());
    return inherited.data;
  }

}

class CustomThemeState extends State<CustomTheme> {
  ThemeData _theme;
  ThemeData get theme => _theme;

  @override
  void initState() {
    super.initState();
    _theme = MyThemes.getThemeFromKey(widget.initialThemeKey);
  }

  bool isDarkTheme () {
    return _theme == darkTheme();
  }

  void changeTheme(MyThemeKeys key) {
    PreferencesUtil.setTheme(key.toString());
    setState(() {
      _theme = MyThemes.getThemeFromKey(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _CustomTheme(
      data: this,
      child: widget.child,
    );
  }

}