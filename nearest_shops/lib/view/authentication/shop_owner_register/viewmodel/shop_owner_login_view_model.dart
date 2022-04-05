import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../../core/init/service/firestorage/firestore_service.dart';
import '../../../product/showdialog/show_dialog.dart';
import '../../login/view/login_view.dart';

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
    passwordFirstController = TextEditingController();
  }

  Future<void> registerOwnerData(BuildContext context) async {
    isLoadingChange();
    if (formState.currentState!.validate()) {
      try {
        final user = await FirebaseAuthentication.instance
            .createUserWithEmailandPassword(
                email: emailController!.text,
                password: passwordLaterController!.text);

        if (user != null) {
          GeoPoint geoPoint = GeoPoint(10, 25);
          Map<String, dynamic> ownerMapData = {
            "address": businessAdressController!.text,
            "email": emailController!.text,
            "location": geoPoint,
            "logoUrl": "",
            "name": businessNameController!.text,
            "phoneNumber": businessPhoneController!.text,
            "id": user.uid
          };

          await FirestoreService.instance.registerOwner(ownerMapData);

          await FirebaseAuthentication.instance
              .setUserRole(UserRole.BUSINESS.roleRawValue, user.uid);
          if (!user.emailVerified) {
            await user.sendEmailVerification();
          }
          await FirebaseAuthentication.instance.signOut();
          await ShowRegisterAlertDialog.instance.getAlertDialog(context);
          context.navigateToPage(LoginView());
        }
      } on FirebaseAuthException catch (e) {
        if (scaffoldState.currentState != null) {
          scaffoldState.currentState!
              .showSnackBar(SnackBar(content: Text(e.message.toString())));

          /// Navigator.pop(context);
        }
      } catch (e) {
        print(e.toString());
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
