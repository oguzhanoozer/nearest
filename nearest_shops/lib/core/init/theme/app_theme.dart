import 'package:flutter/material.dart';

import 'color/color_manager.dart';
import 'color/dark_color.dart';
import 'color/light_color.dart';
import 'text/dark_text.dart';
import 'text/light_text.dart';
import 'text/text_theme_manager.dart';

abstract class ITheme {
  ITextTheme get textTheme;
  IColors get colors;
}

abstract class ThemeManager {
  static ThemeData createTheme(ITheme theme) => ThemeData(
      fontFamily: theme.textTheme.fontFamily,
      textTheme: theme.textTheme.data,
      colorScheme: theme.colors.colorScheme,
      scaffoldBackgroundColor: theme.colors.scaffoldBackgroundColor,
      appBarTheme:
          AppBarTheme(backgroundColor: theme.colors.appBarColor, elevation: 0),
      inputDecorationTheme: buildInputDecorationTheme(theme));
}

InputDecorationTheme buildInputDecorationTheme(ITheme theme) {
  return InputDecorationTheme(
      //  helperStyle: TextStyle(color: Colors.red),
      // counterStyle: TextStyle(color: Colors.red),
      floatingLabelStyle: TextStyle(color: theme.colors.colors.orange),
      focusColor: Colors.black12,
      filled: true,
      
      errorStyle: TextStyle(color:theme.colors.colors.red),
      fillColor: theme.colors.colors.lightGray,
      labelStyle: TextStyle(),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme.colors.colors.red, width: 0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme.colors.colors.lightGray),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: theme.colors.colors.orange),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme.colors.colors.darkGrey),
        borderRadius: BorderRadius.circular(10),
      ));
}

class AppThemeDark extends ITheme {
  @override
  IColors get colors => DarkColors();

  @override
  ITextTheme get textTheme => TextThemeDark(colors.colors.mediumGrey);
}

class AppThemeLight extends ITheme {
  @override
  IColors get colors => LightColors();

  @override
  ITextTheme get textTheme => TextThemeLight(colors.colors.darkerGrey);
}
