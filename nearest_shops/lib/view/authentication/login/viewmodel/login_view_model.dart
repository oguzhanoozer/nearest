import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/service/firebase_authentication.dart';
import '../../onboard/view/onboard_view.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController? emailController;
  TextEditingController? passwordController;

  @observable
  bool isLoading = false;

  @observable
  bool isLockOpen = false;

  void setContext(BuildContext context) => this.context = context;
  void init() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailController!.text = "oguzoozer@gmail.com";
    passwordController!.text = "123456";
  }

  Future<void> checkUserData() async {
    isLoadingChange();

    if (formState.currentState!.validate()) {
      try {
        final user = await FirebaseAuthentication.instance
            .signWithEmailandPassword(
                email: emailController!.text,
                password: passwordController!.text);
        if (!user!.emailVerified) {
        
          await FirebaseAuthentication.instance.signOut();
          await getAlertDialog(context!);
        }
        context!.navigateToPage(OnBoardView());
      } on FirebaseAuthException catch (e) {
        if (scaffoldState.currentState != null) {
          scaffoldState.currentState!
              .showSnackBar(SnackBar(content: Text(e.message.toString())));
        }
      }
    }
    isLoadingChange();
  }

  Future<bool?> getAlertDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Verification is needed!"),
        content: Text(
            "You have to verify entered email via send verication email link."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> signWithGoogle() async {
    try {
      final user = await FirebaseAuthentication.instance.signInWithGoogle();
      print(user);
    } on FirebaseAuthException catch (e) {
      if (scaffoldState.currentState != null) {
        scaffoldState.currentState!
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      }
    }
  }

  @action
  void isLoadingChange() {
    isLoading = !isLoading;
  }

  @action
  void isLockStateChange() {
    isLockOpen = !isLockOpen;
  }
}
