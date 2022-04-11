import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../../../utility/error_helper.dart';

import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../authentication/login/model/user_model.dart';

abstract class IUserFavouriteListService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IUserFavouriteListService(this.scaffoldState, this.context);
  Future<List<ProductDetailModel>?> fetchFavouriteProductList();
  Future<void> removeItemToFavouriteList(String favouriteItem);
}

class UserFavouriteListService extends IUserFavouriteListService
    with ErrorHelper {
  UserFavouriteListService(
      GlobalKey<ScaffoldState> scaffoldState, BuildContext context)
      : super(scaffoldState, context);

  @override
  Future<List<ProductDetailModel>?> fetchFavouriteProductList() async {
    List<ProductDetailModel> _favouriteProductList = [];
    try {
      List<String> _favouriteList = await returnUserFavouriteList() ?? [];

      if (_favouriteList.isNotEmpty) {
        await Future.forEach(_favouriteList, (item) async {
          final productQuery = await FirebaseCollectionRefInitialize
              .instance.productsCollectionReference
              .where("productId", isEqualTo: item)
              .get();

          if (productQuery.docs.isNotEmpty) {
            _favouriteProductList.add(ProductDetailModel.fromJson(
                productQuery.docs.toList().first.data() as Map));
          }
        });
      }
      return _favouriteProductList;
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
      return null;
    }
  }

  Future<List<String>?> returnUserFavouriteList() async {
    try {
      final userId = await UserIdInitalize.instance.returnUserId();

      final userQuery = await FirebaseCollectionRefInitialize
          .instance.usersCollectionReference
          .where("id", isEqualTo: userId)
          .get();

      List<DocumentSnapshot> userDocs = userQuery.docs;

      if (userDocs.isNotEmpty) {
        UserModel userModel = UserModel.fromJson(userDocs.first.data() as Map);
        return userModel.favouriteList;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
      return null;
    } catch (e) {
      showSnackBar(scaffoldState, context, e.toString());
      return null;
    }
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
}
