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
          backgroundColor: MaterialStateProperty.all(this.color),
          padding: MaterialStateProperty.all(context.paddingLow),
          //minimumSize: MaterialStateProperty.all(Size(context.width * 0.4, 50)),
          fixedSize: fixedSize == null
              ? MaterialStateProperty.all(
                  Size(context.width * 0.5, context.height * 0.06))
              : MaterialStateProperty.all(fixedSize),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
          elevation: MaterialStateProperty.all(5)),
      onPressed: onPressed,
      child: child,
    );
  }
}
