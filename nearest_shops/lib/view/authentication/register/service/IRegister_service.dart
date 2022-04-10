import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../login/view/login_view.dart';

abstract class IRegisterService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IRegisterService(this.scaffoldState, this.context);
  Future<void> registerUser({required String email, required String password});
}

class RegisterService extends IRegisterService with ErrorHelper {
  RegisterService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context)
      : super(scaffoldState, context);

  @override
  Future<void> registerUser(
      {required String email, required String password}) async {
    try {
      final user = await FirebaseAuthentication.instance
          .createUserWithEmailandPassword(email: email, password: password);
      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
        await FirebaseAuthentication.instance
            .setUserRole(UserRole.USER.roleRawValue, user.uid);
        await FirebaseAuthentication.instance.signOut();
        await showVerificationAlertDialog(context);
        context.navigateToPage(LoginView());
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
    }
  }
}
