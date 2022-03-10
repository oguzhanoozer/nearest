import 'package:flutter/material.dart';

class AppColors {
  final Color white = Color(0xffffffff);
  final Color green = Color(0xff7bed8d);
  final Color mediumGrey = Color(0xffa6bcd0);
  final Color mediumGreyBold = Color(0xff748a9d);
  final Color lightGray = Color(0xfff7f7f7);
  final Color lighterGrey = Color(0xfff0f4f8);
  final Color lightGrey = Color(0xffdbe2ed);
  final Color darkerGrey = Color(0xff404e5a);
  final Color darkGrey = Color(0xff4e5d6a);
  final Color orange = Color(0xffff9840);
  final Color lightOrange = Color(0xFFFFF3E0);
  final Color black = Color(0xff000000);
  final Color grey = Color(0xFF9E9E9E);
  final Color yellow = Color(0xFFFFEB3B);
  final Color red = Color(0xFFF44336);
}

abstract class IColors {
  AppColors get colors;
  Color? scaffoldBackgroundColor;
  Color? appBarColor;
  Color? tabBarColor;
  Color? tabbarSelectedColor;
  Color? tabbarNormalColor;
  Brightness? brightness;
  ColorScheme? colorScheme;
}
