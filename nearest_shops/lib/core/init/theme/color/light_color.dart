import 'dart:ui';

import 'package:flutter/material.dart';
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
    appBarColor = colors.lightBackgroundColor;

    scaffoldBackgroundColor = colors.lightBackgroundColor;
    tabBarColor = colors.green;
    tabbarNormalColor = colors.darkerGrey;
    tabbarSelectedColor = colors.green;

    colorScheme = ColorScheme.light().copyWith(
        background: colors.lightBackgroundColor,
        onSurfaceVariant: colors.green,
        onInverseSurface: colors.lightOrange,
        primary: colors.black,
        onSecondary: colors.white,
        onSecondaryContainer: colors.lightShadowGreyColor,
        onPrimaryContainer: colors.red,
        onSurface: colors.mediumGreyBold,
        brightness: Brightness.light,
        surface: colors.grey,
        onPrimary: colors.darkGrey,
        primaryContainer: colors.darkerGrey,
        surfaceVariant: colors.mediumGrey,
        inverseSurface: colors.lightGrey,
        inversePrimary: colors.white,
        onTertiary: colors.lightShimmerColor,
        onTertiaryContainer: colors.shimmerGreyTwo);
    brightness = Brightness.light;
  }
}
