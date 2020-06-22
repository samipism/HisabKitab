import 'package:flutter/material.dart';

class BasicTheme {
  static Color _primary = Color(0xff303f9f);
  static Color _primaryVariant = Color(0xff283593);
  static Color _onPrimary = Color(0xffffffff);
  static Color _secondary = Color(0xff4db6ac);
  static Color _secondaryVariant = Color(0xff26a69a);
  static Color _onSecondary = Color(0xff000000);
  static Color _error = Color(0xffB00020);
  static Color _onError = Color(0xffffffff);
  static Color _backGround = Color(0xffffffff);
  static Color _onBackGround = Color(0xff000000);
  static Brightness _brightnessLight = Brightness.light;
  static Color _surface = Color(0xfffafafa);

  static TextTheme _textTheme = TextTheme(
    headline1: TextStyle(fontFamily: "Oxygen"),
    headline2: TextStyle(fontFamily: "Oxygen"),
    headline3: TextStyle(fontFamily: "Oxygen"),
    headline4: TextStyle(fontFamily: "Oxygen"),
    headline5: TextStyle(fontFamily: "Oxygen"),
    headline6: TextStyle(fontFamily: "Oxygen"),
    button: TextStyle(fontFamily: "Oxygen"),
    bodyText1: TextStyle(fontFamily: "Oxygen"),
    bodyText2: TextStyle(fontFamily: "Oxygen"),
    caption: TextStyle(fontFamily: "Oxygen"),
    subtitle1: TextStyle(fontFamily: "Oxygen"),
    subtitle2: TextStyle(fontFamily: "Oxygen"),
    overline: TextStyle(fontFamily: "Oxygen"),
  );
  static ButtonThemeData _buttonThemeData = ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  static ThemeData mainTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
        alignLabelWithHint: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
    buttonTheme: _buttonThemeData,
    snackBarTheme: SnackBarThemeData(backgroundColor: Colors.purple[500]),
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
        color: _primary, iconTheme: IconThemeData(color: _onSecondary)),
    colorScheme: ColorScheme.light(
        brightness: _brightnessLight,
        onBackground: _onBackGround,
        primary: _primary,
        primaryVariant: _primaryVariant,
        onPrimary: _onPrimary,
        secondary: _secondary,
        secondaryVariant: _secondaryVariant,
        onSecondary: _onSecondary,
        error: _error,
        onError: _onError,
        background: _backGround,
        surface: _surface),
  );
}
