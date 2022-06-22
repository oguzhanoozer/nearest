import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';

InputDecoration buildInputDecoration(BuildContext context,
    {Color? prefixIconColor, IconData? prefixIcon, Color? fillColor, Widget? suffixIcon, required String hintText}) {
  return InputDecoration(
      filled: true,
      fillColor: context.colorScheme.onSecondary,
      errorStyle: errorTextStyle(context),
      contentPadding: EdgeInsets.zero,
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(width: 0.0, color: context.colorScheme.onSecondary), borderRadius: context.normalBorderRadius / 2),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(width: 0.0, color: context.colorScheme.onSecondary), borderRadius: context.normalBorderRadius / 2),
      disabledBorder:
          OutlineInputBorder(borderSide: BorderSide(width: 0.0, color: context.colorScheme.onSecondary), borderRadius: context.normalBorderRadius / 2),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.0, color: context.colorScheme.onSecondary), borderRadius: context.normalBorderRadius / 2),
      prefixIcon: Icon(prefixIcon != null ? prefixIcon : Icons.search,
          color: prefixIconColor != null ? prefixIconColor : context.colorScheme.surface, size: context.dynamicHeight(0.03)),
      hintStyle: inputTextStyle(context),
      hintText: hintText,
      suffixIcon: suffixIcon);
}

TextStyle inputTextStyle(BuildContext context) {
  return GoogleFonts.lora(fontSize: 15, color: context.colorScheme.surface);
}

TextStyle errorTextStyle(BuildContext context) {
  return GoogleFonts.lora(fontSize: 10, color: context.colorScheme.onPrimaryContainer);
}

TextStyle titleTextStyle(BuildContext context, {double fontsize = 16}) {
  return GoogleFonts.lora(
      textStyle: context.textTheme.bodyText2!.copyWith(fontSize: fontsize, fontWeight: FontWeight.w800, color: context.colorScheme.primary));
}

TextStyle summaryTextStyle(BuildContext context) {
  return GoogleFonts.lora(textStyle: context.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 10, color: context.colorScheme.primary));
}

TextStyle emailTextStyle(BuildContext context) {
  return GoogleFonts.lora(textStyle: context.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500, color: context.colorScheme.primary));
}

TextStyle priceTextStyle(BuildContext context) {
  return GoogleFonts.lora(textStyle: context.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.primary));
}

TextStyle headline6TextSTyle(BuildContext context) {
  return GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(color: context.colorScheme.primary));
}
