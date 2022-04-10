import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/view/authentication/register/service/IRegister_service.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';

import '../../login/view/login_view.dart';

part 'register_view_model.g.dart';

class RegisterViewModel = _RegisterViewModelBase with _$RegisterViewModel;

abstract class _RegisterViewModelBase with Store, BaseViewModel, ErrorHelper {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController? emailController;
  TextEditingController? passwordFirstController;
  TextEditingController? passwordLaterController;

  late IRegisterService registerService;

  @observable
  bool isLoading = false;

  @observable
  bool isFirstLockOpen = false;

  @observable
  bool isLaterLockOpen = false;

  void setContext(BuildContext context) {
    this.context = context;
    registerService = RegisterService(scaffoldState,context);
  }

  void init() {
    emailController = TextEditingController();
    passwordFirstController = TextEditingController();
    passwordLaterController = TextEditingController();
    passwordFirstController!.text = "123456";
    passwordLaterController!.text = "123456";
    emailController!.text = "oguzoozer@gmail.com";
  }

  Future<void> checkUserData() async {
    isLoadingChange();
    if (formState.currentState!.validate()) {
      await registerService.registerUser(
          email: emailController!.text,
          password: passwordLaterController!.text);
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
