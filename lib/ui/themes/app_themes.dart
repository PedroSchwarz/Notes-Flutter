import 'package:flutter/material.dart';
import 'package:notes/ui/themes/color_modes.dart';
import 'package:notes/ui/themes/text_themes.dart';

class AppThemes {
  static final ThemeData lighTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    accentColor: Colors.deepOrange,
    textTheme: TextTheme(
      headline1: TextThemes.headline(ColorModes.light),
      subtitle1: TextThemes.itemTitle(ColorModes.light),
    ),
    buttonTheme: _buttonTheme.copyWith(
      buttonColor: Colors.deepOrange,
    ),
    cardTheme: _cardTheme.copyWith(
      color: Color(0xffEEEEEE),
    ),
    floatingActionButtonTheme: _floatingButtonTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xff363636),
    accentColor: Color(0xff514e54),
    primaryColorDark: Color(0xff000000),
    primaryColorLight: Color(0xffffffff),
    scaffoldBackgroundColor: Color(0xff4a4a4a),
    textTheme: TextTheme(
      headline1: TextThemes.headline(ColorModes.dark),
      subtitle1: TextThemes.itemTitle(ColorModes.dark),
    ),
    buttonTheme: _buttonTheme.copyWith(
      buttonColor: Color(0xff514e54),
    ),
    cardTheme: _cardTheme.copyWith(
      color: Color(0xff514e54),
    ),
    floatingActionButtonTheme: _floatingButtonTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final FloatingActionButtonThemeData _floatingButtonTheme =
      FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  static final ButtonThemeData _buttonTheme = ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    textTheme: ButtonTextTheme.primary,
  );

  static final CardTheme _cardTheme = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}
