import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../utility/error_helper.dart';
import '../service/IReset_password_service.dart';

part 'reset_password_view_model.g.dart';

class ResetPasswordViewModel = _ResetPasswordViewModelBase with _$ResetPasswordViewModel;

abstract class _ResetPasswordViewModelBase with Store, BaseViewModel, ErrorHelper {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @observable
  bool isResetEmailSend = false;

  TextEditingController? emailResetTextController;
  late IResetPasswordService resetPasswordService;

  @override
  void setContext(BuildContext context) {
    this.context = context;
    resetPasswordService = ResetPasswordService(scaffoldState, context);
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
    if (formState.currentState!.validate() && emailResetTextController != null) {
      {
        await resetPasswordService.resetUserPassword(email: emailResetTextController!.text);
      }
    }
    emailResetTextController!.text = "";
    changeResetEmail();
  }
}
