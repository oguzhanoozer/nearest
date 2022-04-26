import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../service/IChange_password_service.dart';

part 'change_password_view_model.g.dart';

class ChangePasswordViewModel = _ChangePasswordViewModelBase
    with _$ChangePasswordViewModel;

abstract class _ChangePasswordViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController? currentPasswordController;
  TextEditingController? newFirstPasswordController;
  TextEditingController? newSecondPasswordController;

  late IChangePasswordService _changePasswordService;

  @observable
  bool isLoading = false;

  @observable
  bool isFirstLockOpen = false;

  @observable
  bool isLaterLockOpen = false;

  @observable
  bool isCurrentLockOpen = false;

  @override
  init() {
    currentPasswordController = TextEditingController();
    newFirstPasswordController = TextEditingController();
    newSecondPasswordController = TextEditingController();
  }

  @override
  setContext(BuildContext context) {
    context = context;
    _changePasswordService = ChangePasswordService(scaffoldState, context);
  }

  @action
  Future<void> updataPassword() async {
    isLoadingChange();
    if (formState.currentState!.validate()) {
      await _changePasswordService.changeUserPassword(
          currentPasswordController!.text, newSecondPasswordController!.text);
      currentPasswordController!.text = "";
      newFirstPasswordController!.text = "";
      newSecondPasswordController!.text = "";
    }
    isLoadingChange();
  }

  @action
  void isFirstLockStateChange() {
    isFirstLockOpen = !isFirstLockOpen;
  }

  @action
  void isLaterLockStateChange() {
    isLaterLockOpen = !isLaterLockOpen;
  }

  @action
  void isCurrentLockOpenchange() {
    isCurrentLockOpen = !isCurrentLockOpen;
  }

  @action
  void isLoadingChange() {
    isLoading = !isLoading;
  }
}
