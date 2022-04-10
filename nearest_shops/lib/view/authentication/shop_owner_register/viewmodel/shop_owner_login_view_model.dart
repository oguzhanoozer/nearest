import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/view/shop_owner/shop_owner_product_list/view/shop_owner_product_list_view.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../../core/init/service/firestorage/firestore_service.dart';
import '../../login/view/login_view.dart';
import '../service/IShop_owner_register_service.dart';

part 'shop_owner_login_view_model.g.dart';

class ShopOwnerRegisterViewModel = _ShopOwnerRegisterViewModelBase
    with _$ShopOwnerRegisterViewModel;

abstract class _ShopOwnerRegisterViewModelBase
    with Store, BaseViewModel, ErrorHelper {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController? businessNameController;
  TextEditingController? businessAdressController;
  TextEditingController? businessPhoneController;
  TextEditingController? emailController;
  TextEditingController? passwordFirstController;
  TextEditingController? passwordLaterController;

  late IShopOwnerRegisterService shopOwnerRegisterService;

  @observable
  bool isLoading = false;

  @observable
  bool isFirstLockOpen = false;

  @observable
  bool isLaterLockOpen = false;

  void setContext(BuildContext context) {
    this.context = context;
    shopOwnerRegisterService = ShopOwnerRegisterService(scaffoldState, context);
  }

  void init() {
    businessNameController = TextEditingController();
    businessAdressController = TextEditingController();
    businessPhoneController = TextEditingController();
    emailController = TextEditingController();
    passwordLaterController = TextEditingController();
    passwordFirstController = TextEditingController();
  }

  Future<void> registerOwnerData(BuildContext context) async {
    isLoadingChange();
    if (formState.currentState!.validate()) {
      GeoPoint geoPoint = GeoPoint(10, 25);
      Map<String, dynamic> ownerMapData = {
        "address": businessAdressController!.text,
        "email": emailController!.text,
        "location": geoPoint,
        "logoUrl": "",
        "name": businessNameController!.text,
        "phoneNumber": businessPhoneController!.text
      };

      await shopOwnerRegisterService.shopOwnerRegister(
          email: emailController!.text,
          password: passwordLaterController!.text,
          ownerMapData: ownerMapData);
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
