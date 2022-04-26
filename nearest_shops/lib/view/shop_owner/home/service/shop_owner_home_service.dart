import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../home/shop_list/model/shop_model.dart';
import '../../../utility/error_helper.dart';

import '../../../../core/init/service/firestorage/firestorage_initialize.dart';

abstract class IShopOwnerHomeService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IShopOwnerHomeService(this.scaffoldState, this.context);

  Future<void> updateShopLocation(GeoPoint geoPoint);
  Future<ShopModel?> fetchShopLocation();
}

class ShopOwnerHomeService extends IShopOwnerHomeService with ErrorHelper {
  ShopOwnerHomeService(
      GlobalKey<ScaffoldState> scaffoldState, BuildContext context)
      : super(scaffoldState, context);

  Future<void> updateShopLocation(GeoPoint geoPoint) async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();
      if (user != null) {
        Map<String, dynamic> updateGeoPointData = {"location": geoPoint};

        await FirebaseCollectionRefInitialize.instance.shopsCollectionReference
            .doc(user.uid)
            .update(updateGeoPointData);
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.errorOnUpdateLocationText.locale);
    }
  }

  Future<ShopModel?> fetchShopLocation() async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();
      if (user != null) {
        final shopsListQuery = await FirebaseCollectionRefInitialize
            .instance.shopsCollectionReference
            .get();
        List<DocumentSnapshot> docsInShops = shopsListQuery.docs;
        if (docsInShops.isNotEmpty) {
          ShopModel shopModel =
              ShopModel.fromJson(docsInShops.first.data() as Map);
          return shopModel;
        }
      }
    } catch (e) {
      showSnackBar(scaffoldState, context,  LocaleKeys.errorOnUploadingProfileImagaText.locale);
      return null;
    }
  }
}
