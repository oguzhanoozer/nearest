import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../model/shop_model.dart';

abstract class IShopListService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IShopListService(this.scaffoldState, this.context);
  Future<List<ShopModel>?> fetchShopList();
}

class ShopListService extends IShopListService with ErrorHelper {
  ShopListService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context)
      : super(scaffoldState, context);

  @override
  Future<List<ShopModel>?> fetchShopList() async {
    List<ShopModel> _shopModelList = [];

    try {
      final shopsListQuery = await FirebaseCollectionRefInitialize
          .instance.shopsCollectionReference
          .get();

      List<DocumentSnapshot> docsInShops = shopsListQuery.docs;
      if (docsInShops.isNotEmpty) {
        for (var element in docsInShops) {
          ShopModel shopModel = ShopModel.fromJson(element.data() as Map);
          _shopModelList.add(shopModel);
        }
      }
      return _shopModelList;
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
      return null;
    }
  }
}
