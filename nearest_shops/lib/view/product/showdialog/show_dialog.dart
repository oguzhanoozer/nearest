import 'package:flutter/material.dart';

class ShowRegisterAlertDialog {
  static ShowRegisterAlertDialog _instance = ShowRegisterAlertDialog._init();

  static ShowRegisterAlertDialog get instance => _instance;

  ShowRegisterAlertDialog._init();

  Future<void> getAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Verification is needed!"),
        content: Text(
            "You have to verify entered email via send verication email link."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
