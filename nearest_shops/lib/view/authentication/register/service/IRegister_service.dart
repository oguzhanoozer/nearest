import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';

import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../utility/error_helper.dart';
import '../../login/view/login_view.dart';

abstract class IRegisterService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IRegisterService(this.scaffoldState, this.context);
  Future<void> registerUser({required String email, required String password});
}

class RegisterService extends IRegisterService with ErrorHelper {
  RegisterService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) : super(scaffoldState, context);

  @override
  Future<void> registerUser({required String email, required String password}) async {
    try {
      final user = await FirebaseAuthentication.instance.createUserWithEmailandPassword(email: email, password: password);
      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }

        ///await FirebaseAuthentication.instance.signOut();
        await FirebaseAuthentication.instance.setUserRole(UserRole.USER.roleRawValue, user.uid);

        await showVerificationAlertDialog(context);
        Navigator.pushReplacementNamed(context, loginViewRoute);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthErrorString.EMAIL_ALREADY_IN_USE.rawValue) {
        showSnackBar(scaffoldState, context, LocaleKeys.errorEmailAlreadyInUse.locale);
      } else if (e.code == AuthErrorString.INVALID_EMAIL.rawValue) {
        showSnackBar(scaffoldState, context, LocaleKeys.errorInvalidEmail.locale);
      } else if (e.code == AuthErrorString.OPERATION_NOT_ALLOWED.rawValue) {
        showSnackBar(scaffoldState, context, LocaleKeys.errorOperationNotAllowed.locale);
      } else if (e.code == AuthErrorString.WEAK_PASSWORD.rawValue) {
        showSnackBar(scaffoldState, context, LocaleKeys.errorWeakPassword.locale);
      } else {
        showSnackBar(scaffoldState, context, LocaleKeys.registerError.locale);
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.registerError.locale);
    }
  }
}
