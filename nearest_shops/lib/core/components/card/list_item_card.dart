import 'package:flutter/material.dart';

class ListItemCard extends Card {
  ListItemCard(
      {Key? key,
      bool onlyBottomRadius = false,
      required Color color,
      required Widget child,
      required double radius,
      EdgeInsetsGeometry margin = EdgeInsets.zero,
      double elevation = 0.3,
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
                borderRadius: !onlyBottomRadius
                    ? BorderRadius.all(Radius.circular(radius))
                    : BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))));
}
