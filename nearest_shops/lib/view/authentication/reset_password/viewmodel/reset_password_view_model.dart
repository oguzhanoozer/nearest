import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/base_view_model.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/authentication/login/view/login_view.dart';

import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
part 'reset_password_view_model.g.dart';

class ResetPasswordViewModel = _ResetPasswordViewModelBase
    with _$ResetPasswordViewModel;

abstract class _ResetPasswordViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @observable
  bool isResetEmailSend = false;

  TextEditingController? emailResetTextController;

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void init() {
    emailResetTextController = TextEditingController();
  }

  @action
  void changeResetEmail() {
    isResetEmailSend = !isResetEmailSend;
  }

  Future<void> sendResetPasswordEmail() async {
    changeResetEmail();
    if (formState.currentState!.validate() &&
        emailResetTextController != null) {
      {
        try {
          await FirebaseAuthentication.instance
              .resetPassword(email: emailResetTextController!.text);

          showSnackBar(message: "Please check your email box");

          await Future.delayed(Duration(seconds: 2));

          context!.navigateToPage(LoginView());
        } on FirebaseAuthException catch (e) {
          showSnackBar(message: e.message.toString());
        }
      }
    }
    emailResetTextController!.text = "";
    changeResetEmail();
  }

  void showSnackBar({required String message}) {
    if (scaffoldState.currentState != null) {
      scaffoldState.currentState!
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
