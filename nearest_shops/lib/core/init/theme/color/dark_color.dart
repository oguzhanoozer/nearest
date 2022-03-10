import 'dart:ui';

import 'package:flutter/src/material/color_scheme.dart';

import 'color_manager.dart';

class DarkColors implements IColors {
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

  AppColors colors = AppColors();

  DarkColors() {
    appBarColor = colors.darkGrey;
    scaffoldBackgroundColor = colors.darkGrey;
    tabBarColor = colors.green;
    tabbarNormalColor = colors.lighterGrey;
    tabbarSelectedColor = colors.green;
    colorScheme = ColorScheme.dark()
        .copyWith(onPrimary: colors.green, onSecondary: colors.darkGrey);
    brightness = Brightness.dark;
  }
}
