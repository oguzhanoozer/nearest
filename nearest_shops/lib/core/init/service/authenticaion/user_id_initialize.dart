import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';
import 'package:nearest_shops/core/init/lang/locale_keys.g.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import 'firebase_authentication.dart';

class UserIdInitalize with ErrorHelper {
  static UserIdInitalize _instance = UserIdInitalize._init();
  UserIdInitalize._init();
  static UserIdInitalize get instance => _instance;

  String? userId;

  Future<String?> returnUserId(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) async {
    if (userId == null) {
      return await _fetchUserId(scaffoldState, context);
    } else {
      return userId;
    }
  }

  void setUserId(String userId) {
    this.userId = userId;
  }

  Future<String?> _fetchUserId(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();

      if (user != null) {
        userId = user.uid;
        return userId;
      } else {}
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }
}
