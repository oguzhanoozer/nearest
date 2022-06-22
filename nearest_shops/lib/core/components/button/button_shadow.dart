import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ButtonShadow extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const ButtonShadow({Key? key, required this.child, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: context.dynamicHeight(0.06),
        child: Center(child: child),
        decoration: buildDecoration(context),
      ),
    );
  }

  BoxDecoration buildDecoration(
    BuildContext context,
  ) {
    double offSetVal = 0.2;
    Offset offset = Offset(offSetVal, offSetVal);
    double blur = 0.1;
    double spreadRadius = 1;

    return BoxDecoration(
      color: context.colorScheme.onSecondary,
      borderRadius: context.normalBorderRadius / 2,
      boxShadow: [
        BoxShadow(color: context.colorScheme.onSecondary, offset: offset, blurRadius: blur, spreadRadius: spreadRadius),
        BoxShadow(color: context.colorScheme.onSecondary, offset: -offset, blurRadius: blur, spreadRadius: spreadRadius),
      ],
    );
  }
}
