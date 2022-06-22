import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/model/base_view_model.dart';

import '../../../../core/base/route/generate_route.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../authentication/onboard/view/onboard_view.dart';
import '../../../home/shop_list/model/shop_model.dart';
import '../service/shop_owner_profile_service.dart';
part 'owner_profile_view_model.g.dart';

class OwnerProfileViewModel = _OwnerProfileViewModelBase with _$OwnerProfileViewModel;

abstract class _OwnerProfileViewModelBase with Store, BaseViewModel {
  final GlobalKey<FormState> formState = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController? businessNameController;
  TextEditingController? businessAdressController;
  TextEditingController? businessPhoneController;
  TextEditingController? emailController;

  @observable
  User? user;

  @observable
  bool profileLoading = false;

  @observable
  bool isImageSelected = false;

  final ImagePicker picker = ImagePicker();

  @observable
  XFile? pickedFile;

  ShopModel? _shopModel;
  late final ShopModel _tempShopModel;

  late IShopOwnerProfileService _shopOwnerProfileService;

  @observable
  String? _imageUrl;

  @observable
  bool isUpdating = false;

  @action
  void changeIsUpdating() {
    isUpdating = !isUpdating;
  }

  @override
  Future<void> init() async {
    changeProfileLoading();

    businessNameController = TextEditingController();
    businessAdressController = TextEditingController();
    businessPhoneController = TextEditingController();
    emailController = TextEditingController();
    user = FirebaseAuthentication.instance.authCurrentUser();

    await fethcShopModel();
    if (_shopModel != null) {
      emailController!.text = _shopModel!.email!;
      businessNameController!.text = _shopModel!.name!;
      businessAdressController!.text = _shopModel!.address!;
      businessPhoneController!.text = _shopModel!.phoneNumber!;
      _imageUrl = _shopModel!.logoUrl;
    }

    changeProfileLoading();
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
    _shopOwnerProfileService = ShopOwnerProfileService(scaffoldState, context);
  }

  String? photoImageUrl() {
    if (_imageUrl != null && _imageUrl!.isNotEmpty) {
      return _imageUrl;
    } else if (user != null) {
      if (user!.photoURL != null && user!.photoURL!.isNotEmpty) {
        return user!.photoURL;
      }
    }
    return null;
  }

  Future<void> fethcShopModel() async {
    _shopModel = await _shopOwnerProfileService.fetchShopData();
    _tempShopModel = _shopModel!;
  }

  Future<void> updateShopData() async {
    if (formState.currentState!.validate()) {
      changeIsUpdating();
      final shopModel = ShopModel(
          name: businessNameController!.text,
          email: emailController!.text,
          address: businessAdressController!.text,
          phoneNumber: businessPhoneController!.text,
          id: _shopModel!.id,
          location: _shopModel!.location,
          logoUrl: _shopModel!.logoUrl);

      await _shopOwnerProfileService.updateShopData(shopModel, _tempShopModel);
      changeIsUpdating();
    }
  }

  @action
  Future<void> selectImage() async {
    isImageSelectedChange();

    pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? url = await _shopOwnerProfileService.uploadProfileImage(File(pickedFile!.path));
      if (url != null) {
        _shopModel!.setLogoUrl(url);
      }
    }

    isImageSelectedChange();
  }

  @action
  void isImageSelectedChange() {
    isImageSelected = !isImageSelected;
  }

  @action
  void changeProfileLoading() {
    profileLoading = !profileLoading;
  }

  Future<void> deleteAccount() async {
    await _shopOwnerProfileService.deleteAccount();
    Navigator.pushReplacementNamed(context!, onBoardViewRoute);
  }
}
