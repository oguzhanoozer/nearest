import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';
import 'package:nearest_shops/core/init/service/firestorage/enum/document_collection_enums.dart';

import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../utility/error_helper.dart';
import '../../product_detail/model/product_detail_model.dart';

abstract class IDashboardService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IDashboardService(this.scaffoldState, this.context);
  Future<List<ProductDetailModel>?> fetchDashboardProductFirstList({bool isFiltered, bool isCategories = false});
  Future<List<ProductDetailModel>?> fetchDashboardProductMoreList({bool isFiltered});
  Future<List<ProductDetailModel>?> fetchDashboardSliderList();
  Future<void> removeItemToFavouriteList(String favouriteItem);
  Future<void> addItemToFavouriteList(String favouriteItem);

  late DocumentSnapshot lastDocument;
}

class DashboardService extends IDashboardService with ErrorHelper {
  DashboardService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) : super(scaffoldState, context);

  @override
  Future<List<ProductDetailModel>?> fetchDashboardSliderList() async {
    List<ProductDetailModel> productList = [];

    try {
      final productListQuery = await FirebaseCollectionRefInitialize.instance.productsCollectionReference.limit(5).get();

      List<DocumentSnapshot> docsInShops = productListQuery.docs;
      for (var element in docsInShops) {
        productList.add(ProductDetailModel.fromJson(element.data() as Map));
      }
      return productList;
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
      return null;
    }
  }

  @override
  Future<List<ProductDetailModel>?> fetchDashboardProductFirstList({bool isFiltered = false, bool isCategories = false}) async {
    List<ProductDetailModel> productList = [];
    try {
      final productListQuery = await FirebaseCollectionRefInitialize.instance.productsCollectionReference.limit(15).get();

      List<DocumentSnapshot> docsInShops = productListQuery.docs;
      if (isCategories == false) {
        if (docsInShops.length > 5) {
          docsInShops.removeRange(0, 5);
        } else {
          docsInShops.removeRange(0, docsInShops.length);
        }
      }

      if (docsInShops.isNotEmpty) {
        for (var element in docsInShops) {
          productList.add(ProductDetailModel.fromJson(element.data() as Map));
        }
        lastDocument = docsInShops.last;
      }
      return productList;
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }

  @override
  Future<List<ProductDetailModel>?> fetchDashboardProductMoreList({bool isFiltered = false}) async {
    List<ProductDetailModel> productList = [];

    try {
      final productListQuery = await FirebaseCollectionRefInitialize.instance.productsCollectionReference.limit(10).startAfterDocument(lastDocument).get();

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
  Future<void> removeItemToFavouriteList(String favouriteItem) async {
    try {
      final userId = await UserIdInitalize.instance.returnUserId(scaffoldState, context);
      Map<String, dynamic> removeItemMap = {
        ContentString.FAVOURITELIST.rawValue: FieldValue.arrayRemove([favouriteItem]),
      };

      await FirebaseCollectionRefInitialize.instance.usersCollectionReference.doc(userId).update(removeItemMap);
    }catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }

  @override
  Future<void> addItemToFavouriteList(String favouriteItem) async {
    try {
      final userId = await UserIdInitalize.instance.returnUserId(scaffoldState, context);

      Map<String, dynamic> addItemMap = {
        ContentString.FAVOURITELIST.rawValue: FieldValue.arrayUnion([favouriteItem]),
      };
      await FirebaseCollectionRefInitialize.instance.usersCollectionReference.doc(userId).update(addItemMap);
    }catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }
}
