import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../utility/error_helper.dart';

abstract class IChangePasswordService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IChangePasswordService(this.scaffoldState, this.context);
  Future<void> changeUserPassword(String currentPassword, String newPassword);
}

class ChangePasswordService extends IChangePasswordService with ErrorHelper {
  ChangePasswordService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) : super(scaffoldState, context);

  @override
  Future<void> changeUserPassword(String currentPassword, String newPassword) async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();

      if (user != null) {
        final credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);

        await user.reauthenticateWithCredential(credential).then((value) async {
          await user.updatePassword(newPassword).then((value) {
            showSnackBar(scaffoldState, context, LocaleKeys.yourPasswordUpdateText.locale);
          }).catchError((value) {
            throw LocaleKeys.errorOnUpdatingPasswordText.locale + value.toString();
          });
        }).catchError((value) {
          throw LocaleKeys.errorOnUpdatingPasswordText.locale +
              (value.code.toString().contains("wrong-password") ? " " + LocaleKeys.dueToWrongPasswordText.locale : ".");
        });
      } else {}
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }
}
