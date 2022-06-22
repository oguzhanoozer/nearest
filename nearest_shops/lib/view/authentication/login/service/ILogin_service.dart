import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';
import 'package:nearest_shops/core/init/lang/locale_keys.g.dart';

import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../utility/error_helper.dart';
import '../../onboard/view/onboard_view.dart';

abstract class ILoginService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  ILoginService(this.scaffoldState, this.context);
  Future<void> loginUser({required String email, required String password});
  Future<void> signWithGoogleUser();
}

class LoginService extends ILoginService with ErrorHelper {
  LoginService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) : super(scaffoldState, context);

  @override
  Future<void> loginUser({required String email, required String password}) async {
    try {
      final user = await FirebaseAuthentication.instance.signWithEmailandPassword(email: email, password: password);
      if (!user!.emailVerified) {
        FirebaseAuthentication.instance.signOut();

        await showVerificationAlertDialog(context);
      }
      Navigator.pushReplacementNamed(context, onBoardViewRoute);
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthErrorString.USER_NOT_FOUND.rawValue) {
        showSnackBar(scaffoldState, context, LocaleKeys.errorUserNotFound.locale);
      } else if (e.code == AuthErrorString.INVALID_EMAIL.rawValue) {
        showSnackBar(scaffoldState, context, LocaleKeys.errorInvalidEmail.locale);
      } else if (e.code == AuthErrorString.USER_DISABLED.rawValue) {
        showSnackBar(scaffoldState, context, LocaleKeys.errorUserDisabled.locale);
      } else if (e.code == AuthErrorString.WRONG_PASSWORD.rawValue) {
        showSnackBar(scaffoldState, context, LocaleKeys.errorWeakPassword.locale);
      } else {
        showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }

  @override
  Future<void> signWithGoogleUser() async {
    try {
      final user = await FirebaseAuthentication.instance.signInWithGoogle();
      if (user != null) {
        await FirebaseAuthentication.instance.setUserRole(UserRole.USER.roleRawValue, user.uid);
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }
}
