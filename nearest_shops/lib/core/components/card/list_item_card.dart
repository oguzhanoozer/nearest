import 'package:flutter/material.dart';

class ListItemCard extends Card {
  ListItemCard({Key? key, required Widget child, required double radius})
      : super(
          key: key,
          child: child,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        );
}
