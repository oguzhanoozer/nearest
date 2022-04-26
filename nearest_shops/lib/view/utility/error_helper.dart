import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../core/extension/string_extension.dart';
import '../../core/init/lang/locale_keys.g.dart';

abstract class ErrorHelper {
  void showSnackBar(GlobalKey<ScaffoldState> scaffoldState,
      BuildContext context, String message) {
    if (scaffoldState.currentState == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: context.durationNormal * 3,
      ),
    );
  }

  Future<void> showVerificationAlertDialog(BuildContext context) async {
    await callAlertDialog(context,
        title: LocaleKeys.vericationIsNeededText.locale,
        content:
           LocaleKeys.youHaveToVerifyEmailText.locale);
  }

  Future<bool?> callAlertDialog(BuildContext context,
      {required String title, required String content}) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
