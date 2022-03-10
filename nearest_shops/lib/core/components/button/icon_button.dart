import 'package:flutter/material.dart';

class NormalIconButton extends StatelessWidget {
  final Widget? icon;
  final VoidCallback? onPressed;

  const NormalIconButton({
    Key? key,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon!,
      onPressed: onPressed,
      iconSize: 70,
    );
  }
}
