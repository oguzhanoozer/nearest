import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';

import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../utility/error_helper.dart';
import '../../login/view/login_view.dart';

abstract class IResetPasswordService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IResetPasswordService(this.scaffoldState, this.context);
  Future<void> resetUserPassword({required String email});
}

class ResetPasswordService extends IResetPasswordService with ErrorHelper {
  ResetPasswordService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) : super(scaffoldState, context);

  @override
  Future<void> resetUserPassword({required String email}) async {
    try {
      await FirebaseAuthentication.instance.resetPassword(email: email);

      showSnackBar(scaffoldState, context, LocaleKeys.pleaseCheckEmailBoxText.locale);

      await Future.delayed(context.durationSlow);

      Navigator.pushNamed(context, loginViewRoute);
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthErrorString.USER_NOT_FOUND.rawValue) {
        showSnackBar(scaffoldState, context, LocaleKeys.errorUserNotFound.locale);
      } else if (e.code == AuthErrorString.INVALID_EMAIL.rawValue) {
        showSnackBar(scaffoldState, context, LocaleKeys.errorInvalidEmail.locale);
      } else {
        showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }
}
