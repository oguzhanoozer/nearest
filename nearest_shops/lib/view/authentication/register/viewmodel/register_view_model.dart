import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/service/firebase_authentication.dart';
import '../../../product/showdialog/show_dialog.dart';
import '../../login/view/login_view.dart';

part 'register_view_model.g.dart';

class RegisterViewModel = _RegisterViewModelBase with _$RegisterViewModel;

abstract class _RegisterViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController? emailController;
  TextEditingController? passwordFirstController;
  TextEditingController? passwordLaterController;

  @observable
  bool isLoading = false;

  @observable
  bool isFirstLockOpen = false;

  @observable
  bool isLaterLockOpen = false;

  void setContext(BuildContext context) => this.context = context;
  void init() {
    emailController = TextEditingController();
    passwordFirstController = TextEditingController();
    passwordLaterController = TextEditingController();
    passwordFirstController!.text = "123456";
    passwordLaterController!.text = "123456";
    emailController!.text = "oguzoozer@gmail.com";
  }

  Future<void> checkUserData(BuildContext context) async {
    isLoadingChange();
    if (formState.currentState!.validate()) {
      try {
        final user = await FirebaseAuthentication.instance
            .createUserWithEmailandPassword(
                email: emailController!.text,
                password: passwordLaterController!.text);
        if (!user!.emailVerified) {
          await user.sendEmailVerification();
        }
        await FirebaseAuthentication.instance.signOut();
        await ShowAlertDialog.instance.getAlertDialog(context);
         context.navigateToPage(LoginView());
      } on FirebaseAuthException catch (e) {
        if (scaffoldState.currentState != null) {
          scaffoldState.currentState!
              .showSnackBar(SnackBar(content: Text(e.message.toString())));

         /// Navigator.pop(context);
        }
      }
    }
    isLoadingChange();
  }

  @action
  void isLoadingChange() {
    isLoading = !isLoading;
  }

  @action
  void isFirstLockStateChange() {
    isFirstLockOpen = !isFirstLockOpen;
  }

  @action
  void isLaterLockStateChange() {
    isLaterLockOpen = !isLaterLockOpen;
  }
}
