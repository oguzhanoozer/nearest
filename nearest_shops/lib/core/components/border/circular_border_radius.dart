import 'package:flutter/cupertino.dart';

class DrawBorderRadius {
  static DrawBorderRadius? _instance;
  static DrawBorderRadius get instance =>
      _instance ??= DrawBorderRadius._init();

  DrawBorderRadius._init();

  BorderRadius allBorderRadius(double value) =>
      BorderRadius.all(Radius.circular(value));

  BorderRadius onlyBorderRadius(double topLeft, double topRight,
          double bottomleft, double bottomRight) =>
      BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomleft),
          bottomRight: Radius.circular(bottomRight));

  BorderRadius verticalBorderRadius(double top, double bottom) =>
      BorderRadius.vertical(
        top: Radius.circular(top),
        bottom: Radius.circular(bottom),
      );

  BorderRadius horizontalBorderRadius(double left, double right) =>
      BorderRadius.horizontal(
        left: Radius.circular(left),
        right: Radius.circular(right),
      );
}
