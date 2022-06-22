import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';

import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../authentication/login/model/user_model.dart';
import '../../../utility/error_helper.dart';
import '../../product_detail/model/product_detail_model.dart';

abstract class IUserFavouriteListService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IUserFavouriteListService(this.scaffoldState, this.context);
  Future<List<ProductDetailModel>?> fetchFavouriteProductList();
  Future<void> removeItemToFavouriteList(String favouriteItem);
}

class UserFavouriteListService extends IUserFavouriteListService with ErrorHelper {
  UserFavouriteListService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) : super(scaffoldState, context);

  @override
  Future<List<ProductDetailModel>?> fetchFavouriteProductList() async {
    List<ProductDetailModel> _favouriteProductList = [];
    try {
      List<String> _favouriteList = await returnUserFavouriteList() ?? [];

      if (_favouriteList.isNotEmpty) {
        await Future.forEach(_favouriteList, (item) async {
          final productQuery =
              await FirebaseCollectionRefInitialize.instance.productsCollectionReference.where(ContentString.PRODUCTID.rawValue, isEqualTo: item).get();

          if (productQuery.docs.isNotEmpty) {
            _favouriteProductList.add(ProductDetailModel.fromJson(productQuery.docs.toList().first.data() as Map));
          }
        });
      }
      return _favouriteProductList;
    }  catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }

  Future<List<String>?> returnUserFavouriteList() async {
    try {
      final userId = await UserIdInitalize.instance.returnUserId(scaffoldState, context);

      final userQuery = await FirebaseCollectionRefInitialize.instance.usersCollectionReference.where(ContentString.ID.rawValue, isEqualTo: userId).get();

      List<DocumentSnapshot> userDocs = userQuery.docs;

      if (userDocs.isNotEmpty) {
        UserModel userModel = UserModel.fromJson(userDocs.first.data() as Map);
        return userModel.favouriteList;
      }
    }  catch (e) {
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
    }  catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }
}
