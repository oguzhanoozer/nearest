import 'package:flutter/material.dart';

class AppColors {
  final Color white = Color(0xffffffff);
  final Color green = Color.fromARGB(255, 26, 126, 43);
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
  final Color blue = Color(0xFF2196F3);

  ///final Color blue = Color.fromARGB(255, 55, 145, 218);
  final Color shimmerGreyOne = Color(0xFFF5F5F5);

  ///grey[100]
  final Color shimmerGreyTwo = Color(0xFFE0E0E0);

  final Color lightShimmerColor = Colors.grey[300]!;
  final Color darkShimmerColor = Color(0xff404e5a);

  ///grey[300]
  final Color lightBackgroundColor = HexColor('#ededed');

  ///Color.fromARGB(255, 227, 228, 227);
  final Color darkBackgroundColor = Color.fromARGB(255, 39, 47, 54);

  final lightShadowGreyColor = Colors.grey.shade900;
  final darkShadowGreyColor = Colors.grey.shade900;

  ///HexColor("#F4F4F6");
}

///Color.fromARGB(255, 7, 87, 19);
///Color.fromARGB(255, 14, 107, 30);
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

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
