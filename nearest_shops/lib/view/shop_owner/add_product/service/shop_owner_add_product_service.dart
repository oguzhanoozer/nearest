import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';

import '../../../../core/init/service/firestorage/firestorage_initialize.dart';

class ShopOwnerAddProductService {
  static ShopOwnerAddProductService _instance =
      ShopOwnerAddProductService._init();
  ShopOwnerAddProductService._init();
  static ShopOwnerAddProductService get instance => _instance;

  Future<void> addProduct(ProductDetailModel productData) async {
    try {
      await FirebaseCollectionRefInitialize.instance.productsCollectionReference
          .doc(productData.productId)
          .set(productData.toMap());
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(ProductDetailModel productData) async {
    try {
      await FirebaseCollectionRefInitialize.instance.productsCollectionReference
          .doc(productData.productId)
          .update(productData.toMap());
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}
