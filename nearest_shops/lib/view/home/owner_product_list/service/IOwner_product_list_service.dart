import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';

import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../utility/error_helper.dart';
import '../../product_detail/model/product_detail_model.dart';

abstract class IOwnerProductListService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IOwnerProductListService(this.scaffoldState, this.context);
  Future<List<DocumentSnapshot>?> fetchDocsInShops();
  Future<List<ProductDetailModel>?> fethcProductListModel({required String shopId});
}

class OwnerProductlistService extends IOwnerProductListService with ErrorHelper {
  OwnerProductlistService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) : super(scaffoldState, context);

  @override
  Future<List<DocumentSnapshot>?> fetchDocsInShops() async {
    try {
      final shopsListQuery = await FirebaseCollectionRefInitialize.instance.shopsCollectionReference.get();

      return shopsListQuery.docs;
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }

  @override
  Future<List<ProductDetailModel>?> fethcProductListModel({required String shopId}) async {
    List<ProductDetailModel> _productsModelList = [];
    try {
      final productListQuery =
          await FirebaseCollectionRefInitialize.instance.productsCollectionReference.where(ContentString.SHOPID.rawValue, isEqualTo: shopId).limit(10).get();

      List<DocumentSnapshot> productDocsInShops = productListQuery.docs;
      for (var element in productDocsInShops) {
        _productsModelList.add(ProductDetailModel.fromJson(element.data() as Map));
      }

      return _productsModelList;
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }
}
