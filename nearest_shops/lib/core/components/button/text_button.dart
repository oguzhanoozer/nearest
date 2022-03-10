import 'package:flutter/material.dart';


class NormalTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const NormalTextButton({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return TextButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
