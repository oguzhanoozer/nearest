import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../onboard/view/onboard_view.dart';

abstract class ILoginService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  ILoginService(this.scaffoldState, this.context);
  Future<void> loginUser({required String email, required String password});
  Future<void> signWithGoogleUser();
}

class LoginService extends ILoginService with ErrorHelper {
  LoginService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context)
      : super(scaffoldState, context);

  @override
  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      final user = await FirebaseAuthentication.instance
          .signWithEmailandPassword(email: email, password: password);
      if (!user!.emailVerified) {
        await FirebaseAuthentication.instance.signOut();
        await showVerificationAlertDialog(
          context,
        );
      }
      context.navigateToPage(const OnBoardView());
    } on FirebaseAuthException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
    }
  }

  @override
  Future<void> signWithGoogleUser() async {
    try {
      final user = await FirebaseAuthentication.instance.signInWithGoogle();
      if (user != null) {
        await FirebaseAuthentication.instance
            .setUserRole(UserRole.USER.roleRawValue, user.uid);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
    }
  }
}
