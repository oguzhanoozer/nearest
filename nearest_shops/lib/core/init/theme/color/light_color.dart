import 'dart:ui';

import 'package:flutter/src/material/color_scheme.dart';

import 'color_manager.dart';

class LightColors implements IColors {
  @override
  Color? appBarColor;

  @override
  Brightness? brightness;

  @override
  ColorScheme? colorScheme;

  @override
  Color? scaffoldBackgroundColor;

  @override
  Color? tabBarColor;

  @override
  Color? tabbarNormalColor;

  @override
  Color? tabbarSelectedColor;

  @override
  AppColors colors = AppColors();

  LightColors() {
    appBarColor = colors.white;
    scaffoldBackgroundColor = colors.white;
    tabBarColor = colors.green;
    tabbarNormalColor = colors.darkerGrey;
    tabbarSelectedColor = colors.green;
    colorScheme = ColorScheme.light().copyWith(
        onSurfaceVariant: colors.orange,
        onInverseSurface: colors.lightOrange,
        primary: colors.black,
        onSecondary: colors.white,
        onSurface: colors.mediumGreyBold,
        brightness: Brightness.light,
        surface: colors.grey,
        onPrimary: colors.darkGrey,
        surfaceVariant: colors.mediumGrey,
        inversePrimary: colors.yellow);
    brightness = Brightness.light;
  }
}
