import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/base_model.dart';

import '../../../../core/base/model/base_view_model.dart';
part 'shop_owner_login_view_model.g.dart';

class ShopOwnerRegisterViewModel = _ShopOwnerRegisterViewModelBase
    with _$ShopOwnerRegisterViewModel;

abstract class _ShopOwnerRegisterViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  
  TextEditingController? businessNameController;
  TextEditingController? businessAdressController;
  TextEditingController? businessPhoneController;
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
    businessNameController = TextEditingController();
    businessAdressController = TextEditingController();
    businessPhoneController = TextEditingController();
    emailController = TextEditingController();
    passwordLaterController = TextEditingController();
    passwordLaterController = TextEditingController();

    // passwordFirstController!.text = "123456";
    // passwordLaterController!.text = "123456";
    // emailController!.text = "oguzoozer@gmail.com";
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
