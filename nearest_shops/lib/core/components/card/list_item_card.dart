import 'package:flutter/material.dart';

class ListItemCard extends Card {
  ListItemCard(
      {Key? key,
      Color color = Colors.white,
      required Widget child,
      required double radius,
      EdgeInsetsGeometry margin = EdgeInsets.zero,
      double elevation = 0.3,
      Color shadowColor = Colors.white,
      BorderSide borderSide = BorderSide.none,
      Clip clipBehavior = Clip.antiAliasWithSaveLayer})
      : super(
            key: key,
            child: child,
            clipBehavior: clipBehavior,
            elevation: elevation,
            color: color,
            margin: margin,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
                side: borderSide,
                borderRadius: BorderRadius.all(Radius.circular(radius))));
}
