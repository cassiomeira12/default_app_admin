import 'package:flutter/material.dart';

const brightness = Brightness.dark;

const primaryColor = Color(0xFF00796B);
const primaryColorLight = Color(0xFF4FAA84);
const primaryColorDark = Color(0xFF004D40);
const accentColor = Color(0xFFFCA639);

const backgroundColor = Color(0xFFF5F5F5);
const errorColor = Colors.redAccent;

ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey[800],
    backgroundColor: Colors.grey[700],
    brightness: brightness,
    textTheme: TextTheme(
      subtitle: TextStyle(
        fontSize: 28,
        color: Colors.white,
      ),
      body1: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
      body2: TextStyle(
        fontSize: 18,
        color: Colors.white70,
      ),
      button: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
      display1: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      display2: TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      display3: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      display4: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
    ),
    // tabBarTheme:
    // accentIconTheme:
    // accentTextTheme:
    // appBarTheme:
    bottomAppBarTheme: BottomAppBarTheme (
      color: Colors.grey[700],
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
      color: Colors.white70,
    ),
    // inputDecorationTheme:
    // pageTransitionsTheme:
    // primaryIconTheme:
    // primaryTextTheme:
    // sliderTheme:
    cardColor: Colors.white70,
    hintColor: Colors.white30,
    errorColor: errorColor,
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    primaryColorDark: primaryColorDark,
    accentColor: accentColor,
    // fontFamily: 'Montserrat',
    buttonColor: Colors.blue[500],
  );
}
