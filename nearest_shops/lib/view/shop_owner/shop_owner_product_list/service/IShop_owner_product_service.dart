import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../../../utility/error_helper.dart';

abstract class IShopOwnerProductListService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IShopOwnerProductListService(this.scaffoldState, this.context);
  Future<ObservableList<ProductDetailModel>?> fetchProductFirstList(String shopId);
  Future<ObservableList<ProductDetailModel>?> fetchProductMoreList(
    String shopId,
  );
  Future<void> deleteProductItem({required String productId});

  late DocumentSnapshot lastDocument;
}

class ShopOwnerProductListService extends IShopOwnerProductListService with ErrorHelper {
  ShopOwnerProductListService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) : super(scaffoldState, context);

  @override
  Future<ObservableList<ProductDetailModel>?> fetchProductFirstList(String shopId) async {
    ObservableList<ProductDetailModel> productList = ObservableList<ProductDetailModel>();
    try {
      final productListQuery =
          await FirebaseCollectionRefInitialize.instance.productsCollectionReference.where(ContentString.SHOPID.rawValue, isEqualTo: shopId).limit(10).get();

      List<DocumentSnapshot> docsInShops = productListQuery.docs;
      for (var element in docsInShops) {
        productList.add(ProductDetailModel.fromJson(element.data() as Map));
      }
      if (docsInShops.isNotEmpty) {
        lastDocument = docsInShops.last;
      }
      return productList;
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }

  @override
  Future<ObservableList<ProductDetailModel>?> fetchProductMoreList(
    String shopId,
  ) async {
    ObservableList<ProductDetailModel> productList = ObservableList<ProductDetailModel>();
    try {
      final productListQuery = await FirebaseCollectionRefInitialize.instance.productsCollectionReference
          .where(ContentString.SHOPID.rawValue, isEqualTo: shopId)
          .limit(10)
          .startAfterDocument(lastDocument)
          .get();

      List<DocumentSnapshot> docsInShops = productListQuery.docs;
      if (docsInShops.isNotEmpty) {
        for (var element in docsInShops) {
          productList.add(ProductDetailModel.fromJson(element.data() as Map));
        }
        lastDocument = docsInShops.last;
      }
      return productList;
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }

  @override
  Future<void> deleteProductItem({required String productId}) async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();
      if (user != null) {
        await FirebaseCollectionRefInitialize.instance.productsCollectionReference.doc(productId).delete();

        await FirebaseStorageInitalize.instance.firabaseStorage.ref("${ContentString.CONTENT.rawValue}/${user.uid}/${productId}").listAll().then((value) {
          value.items.forEach((element) {
            FirebaseStorageInitalize.instance.firabaseStorage.ref(element.fullPath).delete();
          });
        });
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.errorOnDeletingAccountText.locale);
    }
  }
}
