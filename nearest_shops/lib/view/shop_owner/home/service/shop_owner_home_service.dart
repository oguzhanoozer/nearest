import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import '../../../../core/init/service/firestorage/firestorage_initialize.dart';

abstract class IShopOwnerHomeService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IShopOwnerHomeService(this.scaffoldState, this.context);

  Future<void> updateShopLocation(Map<String, dynamic> updateData);
}

class ShopOwnerHomeService extends IShopOwnerHomeService with ErrorHelper {
  ShopOwnerHomeService(
      GlobalKey<ScaffoldState> scaffoldState, BuildContext context)
      : super(scaffoldState, context);

  Future<void> updateShopLocation(Map<String, dynamic> updateData) async {
    try {
      await FirebaseCollectionRefInitialize.instance.shopsCollectionReference
          .doc("234567")
          .update(updateData);
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
    }
  }
}
