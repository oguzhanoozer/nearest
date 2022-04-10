import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

abstract class ErrorHelper {
  void showSnackBar(GlobalKey<ScaffoldState> scaffoldState,
      BuildContext context, String message) {
    if (scaffoldState.currentState == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: context.durationNormal,
      ),
    );
  }

  Future<void> showVerificationAlertDialog(BuildContext context) async {
    await callAlertDialog(context,
        title: "Verification is needed!",
        content:
            "You have to verify entered email via send verication email link.");
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
