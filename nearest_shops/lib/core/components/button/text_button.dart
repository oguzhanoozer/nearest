import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';

class NormalTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const NormalTextButton({Key? key, required this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text,
          style: GoogleFonts.lora(textStyle: context.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.onSurfaceVariant))),
      onPressed: onPressed,
    );
  }
}
