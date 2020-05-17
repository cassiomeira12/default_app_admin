import 'package:flutter/material.dart';

const brightness = Brightness.light;

const primaryColor = Color(0xFF4FAA84);
const primaryColorLight = Color(0xFF4FAA84);
const primaryColorDark = Color(0xFF3C7168);
const accentColor = Color(0xFFFCA639);

const backgroundColor = Color(0xFFF9F9FA);
const errorColor = Color(0xFFB00020);

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    backgroundColor: Colors.white,
    brightness: brightness,
    textTheme: TextTheme(
      subtitle: TextStyle(
        fontSize: 28,
        color: Colors.black45,
      ),
      body1: TextStyle(
        fontSize: 20,
        color: Colors.black45,
      ),
      body2: TextStyle(
        fontSize: 18,
        color: Colors.black45,
      ),
      button: TextStyle(
        fontSize: 14,
        color: Colors.blue,
      ),
      display1: TextStyle(
        fontSize: 18,
        color: Colors.black45,
        fontWeight: FontWeight.bold,
      ),
      display2: TextStyle(
        fontSize: 12,
        color: Colors.black45,
      ),
      display3: TextStyle(
        fontSize: 14,
        color: Colors.black45,
        fontWeight: FontWeight.bold,
      ),
      display4: TextStyle(
        fontSize: 14,
        color: Colors.black54,
        fontWeight: FontWeight.normal,
      ),
    ),
    // tabBarTheme:
    // accentIconTheme:
    // accentTextTheme:
    // appBarTheme:
    bottomAppBarTheme: BottomAppBarTheme (
      color: Colors.white,
      elevation: 5,
    ),
    // buttonTheme: new ButtonThemeData(
    //   buttonColor: Colors.orange,
    //   textTheme: ButtonTextTheme.primary,
    // ),
    // cardTheme: CardTheme(
    //   elevation: 5,
    //   color: Colors.indigo,
    // ),
    // chipTheme:
    // dialogTheme:
    // floatingActionButtonTheme:
    iconTheme: IconThemeData(
      color: Colors.black45,
    ),
    // inputDecorationTheme:
    // pageTransitionsTheme:
    // primaryIconTheme:
    // primaryTextTheme:
    // sliderTheme:
    cardColor: Colors.white,
    hintColor: Colors.grey[350],
    errorColor: errorColor,
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    primaryColorDark: primaryColorDark,
    accentColor: accentColor,
    // fontFamily: 'Montserrat',
    buttonColor: Colors.blue[400],
  );
}
