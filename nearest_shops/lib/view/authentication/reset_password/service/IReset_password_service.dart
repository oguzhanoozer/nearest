import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../../utility/error_helper.dart';

import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../login/view/login_view.dart';

abstract class IResetPasswordService {
   final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IResetPasswordService(this.scaffoldState, this.context);
  Future<void> resetUserPassword(
      {required String email});
}

class ResetPasswordService extends IResetPasswordService with ErrorHelper {
  ResetPasswordService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) : super(scaffoldState, context);

  @override
  Future<void> resetUserPassword(
      {required String email}) async {
    try {
      await FirebaseAuthentication.instance.resetPassword(email: email);

      showSnackBar(scaffoldState, context, "Please check your email box");

      await Future.delayed(context.durationSlow);

      context.navigateToPage(const LoginView());
    } on FirebaseAuthException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
    }
  }
}
