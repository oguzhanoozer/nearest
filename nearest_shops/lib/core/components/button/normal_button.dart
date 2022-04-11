import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class NormalButton extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final VoidCallback? onPressed;
  final Size? fixedSize;
  const NormalButton(
      {Key? key, this.child, this.onPressed, this.color, this.fixedSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all(context.textTheme.headline6!
              .copyWith(color: context.colorScheme.primary)),
          backgroundColor: MaterialStateProperty.all(color),
          padding: MaterialStateProperty.all(context.paddingLow),
          //minimumSize: MaterialStateProperty.all(Size(context.width * 0.4, 50)),
          fixedSize: fixedSize == null
              ? MaterialStateProperty.all(
                  Size(context.dynamicWidth(0.3), context.dynamicWidth(0.02)))
              : MaterialStateProperty.all(fixedSize),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: context.normalBorderRadius)),
          elevation: MaterialStateProperty.all(1)),
      onPressed: onPressed,
      child: FittedBox(child: child),
    );
  }
}
