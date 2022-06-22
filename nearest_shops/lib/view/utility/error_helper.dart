import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/product/input_text_decoration.dart';

import '../../core/extension/string_extension.dart';
import '../../core/init/lang/locale_keys.g.dart';

abstract class ErrorHelper {
  void showSnackBar(GlobalKey<ScaffoldState> scaffoldState, BuildContext context, String message, {bool timeIsLong = false}) {
    if (scaffoldState.currentState == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(30.0),
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: context.normalBorderRadius / 2,
        ),
        backgroundColor: context.colorScheme.onSurfaceVariant,
        content: Text(message, style: GoogleFonts.lora(fontSize: 15, color: context.colorScheme.inversePrimary)),
        duration: timeIsLong ? context.durationNormal * 5 : context.durationNormal * 3,
      ),
    );
  }

  Future<void> showVerificationAlertDialog(BuildContext context) async {
    await callAlertDialog(context, title: LocaleKeys.vericationIsNeededText.locale, content: LocaleKeys.youHaveToVerifyEmailText.locale);
  }

  Future<bool?> callAlertDialog(BuildContext context, {required String title, required String content}) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: titleTextStyle(context)),
        content: Text(content, style: inputTextStyle(context)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              LocaleKeys.okText.locale,
              style: titleTextStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}
