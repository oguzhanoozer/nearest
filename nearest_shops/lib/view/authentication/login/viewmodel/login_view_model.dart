import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../utility/error_helper.dart';
import '../service/ILogin_service.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel, ErrorHelper {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController? emailController;
  TextEditingController? passwordController;

  late ILoginService loginService;

  @observable
  bool isLoading = false;

  @observable
  bool isLockOpen = false;

  void setContext(BuildContext context) {
    this.context = context;
    loginService = LoginService(scaffoldState, context);
  }

  void init() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailController!.text = "oguzoozer@gmail.com";
    passwordController!.text = "123456";
  }

  Future<void> checkUserData() async {
    isLoadingChange();

    if (formState.currentState!.validate()) {
      await loginService.loginUser(
          email: emailController!.text, password: passwordController!.text);
    }
    isLoadingChange();
  }

  Future<void> signWithGoogle() async {
    await loginService.signWithGoogleUser();
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
