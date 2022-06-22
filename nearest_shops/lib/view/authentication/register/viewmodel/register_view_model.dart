import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../utility/error_helper.dart';
import '../service/IRegister_service.dart';

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

  @override
  void setContext(BuildContext context) {
    this.context = context;
    registerService = RegisterService(scaffoldState, context);
  }

  @override
  void init() {
    emailController = TextEditingController();
    passwordFirstController = TextEditingController();
    passwordLaterController = TextEditingController();
    ///passwordFirstController!.text = "123456";
    ///passwordLaterController!.text = "123456";
    ///emailController!.text = "oguzoozer@gmail.com";
  }

  Future<void> checkUserData() async {
    isLoadingChange();
    if (formState.currentState!.validate()) {
      await registerService.registerUser(email: emailController!.text, password: passwordLaterController!.text);
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
