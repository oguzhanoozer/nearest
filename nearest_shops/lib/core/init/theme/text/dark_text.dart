import 'dart:ui';

import 'package:flutter/src/material/text_theme.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

import 'text_theme_manager.dart';

class TextThemeDark implements ITextTheme {
  @override
  TextStyle? bodyText1;

  @override
  TextStyle? bodyText2;

  @override
  late TextTheme data;

  @override
  String? fontFamily;

  @override
  TextStyle? headline1;

  @override
  TextStyle? headline2;

  @override
  TextStyle? headline3;

  @override
  TextStyle? headline4;

  @override
  TextStyle? headline5;

  @override
  TextStyle? headline6;

  @override
  Color? primaryColor;

  @override
  TextStyle? subTitle1;

  @override
  TextStyle? subTitle2;

  TextThemeDark(this.primaryColor) {
    data = TextTheme(
      headline6: TextStyle(fontSize: 20),
      subtitle1: TextStyle(fontSize: 16).apply(color: primaryColor),
    );
    fontFamily = GoogleFonts.spectral().fontFamily;
  }
}
