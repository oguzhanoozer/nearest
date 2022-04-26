// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';

abstract class IShopOwnerAddProductService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IShopOwnerAddProductService(this.scaffoldState, this.context);
  Future<void> addProduct(ProductDetailModel productData);
  Future<void> updateProduct(ProductDetailModel productData);
  Future<List<String>> uploadImage(List<File> pickedFileList, String productId);
  Future<String> uploadFile(File _image, int imageIndex, String productId);
  List<String> imageStoreNameList = [];
}

class ShopOwnerAddProductService extends IShopOwnerAddProductService
    with ErrorHelper {
  ShopOwnerAddProductService(
      GlobalKey<ScaffoldState> scaffoldState, BuildContext context)
      : super(scaffoldState, context);

  @override
  Future<void> addProduct(ProductDetailModel productData) async {
    try {
      await FirebaseCollectionRefInitialize.instance.productsCollectionReference
          .doc(productData.productId)
          .set(productData.toMap());
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
    }
  }

  @override
  Future<void> updateProduct(ProductDetailModel productData) async {
    try {
      await FirebaseCollectionRefInitialize.instance.productsCollectionReference
          .doc(productData.productId)
          .update(productData.toMap());
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
    }
  }

  @override
  Future<List<String>> uploadImage(
      List<File> pickedFileList, String productId) async {
    int _currentIndex = 1;
    List<String> productImageUrlList = [];

    productImageUrlList = await Future.wait(pickedFileList.map((pickedFile) =>
        uploadFile(File(pickedFile.path), _currentIndex++, productId)));

    return productImageUrlList;
  }

  @override
  Future<String> uploadFile(
      File _image, int imageIndex, String productId) async {
    String storageName =
        "${productId} -> ${imageIndex} -> ${DateTime.now().millisecondsSinceEpoch.toString()}";
    imageStoreNameList.add(storageName);

    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();
      if (user != null) {
        TaskSnapshot uploadImageSnapshot = await FirebaseStorageInitalize
            .instance.firabaseStorage
            .ref()
            .child("content")
            .child(user.uid)
            .child(storageName)
            .putFile(_image);

        return await uploadImageSnapshot.ref.getDownloadURL();
      }
    } catch (e) {
      showSnackBar(scaffoldState, context,  LocaleKeys.errorOnDeletingAccountText.locale);
    }
    return "";
  }
}
