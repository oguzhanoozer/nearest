import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';

import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../authentication/login/model/user_model.dart';

abstract class IUserFavouriteListService {
  Future<List<ProductDetailModel>> fetchFavouriteProductList();
  Future<void> removeItemToFavouriteList(String favouriteItem);
}

class UserFavouriteListService extends IUserFavouriteListService {
  @override
  Future<List<ProductDetailModel>> fetchFavouriteProductList() async {
    List<ProductDetailModel> _favouriteProductList = [];

    List<String> _favouriteList = await returnUserFavouriteList() ?? [];
    _favouriteList.add("value");
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

    /*for (var item in _favouriteList) {
        final productQuery = await FirebaseCollectionRefInitialize
            .instance.productsCollectionReference
            .where("productId", isEqualTo: item)
            .get();

        _favouriteProductList.add(ProductDetailModel.fromJson(
            productQuery.docs.toList().first.data() as Map));
      }
      return _favouriteProductList;
      */
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
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
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
