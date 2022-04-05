import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';

import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';

abstract class IDashboardService {
  Future<List<ProductDetailModel>?> fetchDashboardProductFirstList(
      {bool isFiltered});
  Future<List<ProductDetailModel>?> fetchDashboardProductMoreList(
      {bool isFiltered});
  Future<List<ProductDetailModel>?> fetchDashboardSliderList();
  Future<void> removeItemToFavouriteList(String favouriteItem);
  Future<void> addItemToFavouriteList(String favouriteItem);

  late DocumentSnapshot lastDocument;
}

class DashboardService extends IDashboardService {
  @override
  Future<List<ProductDetailModel>?> fetchDashboardSliderList() async {
    List<ProductDetailModel> productList = [];

    final productListQuery = await FirebaseCollectionRefInitialize
        .instance.productsCollectionReference
        .limit(5)
        .get();

    List<DocumentSnapshot> docsInShops = productListQuery.docs;
    for (var element in docsInShops) {
      productList.add(ProductDetailModel.fromJson(element.data() as Map));
    }
    return productList;
  }

  @override
  Future<List<ProductDetailModel>?> fetchDashboardProductFirstList(
      {bool isFiltered = false}) async {
    List<ProductDetailModel> productList = [];

    final productListQuery = await FirebaseCollectionRefInitialize
        .instance.productsCollectionReference

        /// .where("categoryId", isEqualTo: 3)
        .limit(15)
        .get();

    List<DocumentSnapshot> docsInShops = productListQuery.docs;
    if (docsInShops.length > 5) {
      docsInShops.removeRange(0, 5);
    } else {
      docsInShops.removeRange(0, docsInShops.length);
    }
    if (docsInShops.isNotEmpty) {
      for (var element in docsInShops) {
        productList.add(ProductDetailModel.fromJson(element.data() as Map));
      }
      lastDocument = docsInShops.last;
    }
    return productList;
  }

  @override
  Future<List<ProductDetailModel>?> fetchDashboardProductMoreList(
      {bool isFiltered = false}) async {
    List<ProductDetailModel> productList = [];

    final productListQuery = await FirebaseCollectionRefInitialize
        .instance.productsCollectionReference
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
  }

  @override
  Future<void> removeItemToFavouriteList(String favouriteItem) async {
    final userId = await UserIdInitalize.instance.returnUserId();

    Map<String, dynamic> removeItemMap = {
      "favouriteList": FieldValue.arrayRemove([favouriteItem]),
    };

    await FirebaseCollectionRefInitialize.instance.usersCollectionReference
        .doc(userId)
        .update(removeItemMap);
  }

  @override
  Future<void> addItemToFavouriteList(String favouriteItem) async {
    final userId = await UserIdInitalize.instance.returnUserId();

    Map<String, dynamic> addItemMap = {
      "favouriteList": FieldValue.arrayUnion([favouriteItem]),
    };
    await FirebaseCollectionRefInitialize.instance.usersCollectionReference
        .doc(userId)
        .update(addItemMap);
  }
}
