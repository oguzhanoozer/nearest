import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../../../utility/error_helper.dart';

abstract class IShopOwnerProductListService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IShopOwnerProductListService(this.scaffoldState, this.context);
  Future<ObservableList<ProductDetailModel>?> fetchProductFirstList(
      String shopId);
  Future<ObservableList<ProductDetailModel>?> fetchProductMoreList(
    String shopId,
  );
  Future<void> deleteProductItem({required String productId});

  late DocumentSnapshot lastDocument;
}

class ShopOwnerProductListService extends IShopOwnerProductListService with ErrorHelper {
  ShopOwnerProductListService(
      GlobalKey<ScaffoldState> scaffoldState, BuildContext context)
      : super(scaffoldState, context);

  @override
  Future<ObservableList<ProductDetailModel>?> fetchProductFirstList(
      String shopId) async {
    ObservableList<ProductDetailModel> productList =
        ObservableList<ProductDetailModel>();
try{
  
    final productListQuery = await FirebaseCollectionRefInitialize
        .instance.productsCollectionReference
        .where("shopId", isEqualTo: shopId)
        .limit(10)
        .get();

    List<DocumentSnapshot> docsInShops = productListQuery.docs;
    for (var element in docsInShops) {
      productList.add(ProductDetailModel.fromJson(element.data() as Map));
    }
    lastDocument = docsInShops.last;
    return productList;
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
      return null;
    }
  }

  @override
  Future<ObservableList<ProductDetailModel>?> fetchProductMoreList(
    String shopId,
  ) async {
    ObservableList<ProductDetailModel> productList =
        ObservableList<ProductDetailModel>();
try{
    final productListQuery = await FirebaseCollectionRefInitialize
        .instance.productsCollectionReference
        .where("shopId", isEqualTo: shopId)
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
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
      return null;
    }
  }

  @override
  Future<void> deleteProductItem({required String productId}) async {
    await FirebaseCollectionRefInitialize.instance.productsCollectionReference
        .doc(productId)
        .delete();
  }
}
