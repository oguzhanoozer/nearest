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
    appBarColor = colors.darkBackgroundColor;

    scaffoldBackgroundColor = colors.darkBackgroundColor;
    tabBarColor = colors.green;
    tabbarNormalColor = colors.darkerGrey;
    tabbarSelectedColor = colors.green;

    colorScheme = ColorScheme.dark().copyWith(
        background: colors.darkBackgroundColor,
        onSurfaceVariant: colors.green,
        onInverseSurface: colors.lightOrange,
        primary: colors.white,
        onSecondary: colors.darkerGrey,
        onSecondaryContainer: colors.darkShadowGreyColor,
        onPrimaryContainer: colors.red,
        onSurface: colors.mediumGreyBold,
        brightness: Brightness.dark,
        surface: colors.grey,
        onPrimary: colors.darkGrey,
        primaryContainer: colors.darkerGrey,
        surfaceVariant: colors.mediumGrey,
        inverseSurface: colors.lightGrey,
        inversePrimary: colors.white,
        onTertiary: colors.darkShimmerColor,
        onTertiaryContainer: colors.green);
    brightness = Brightness.dark;
  }
}
