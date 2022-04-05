import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';

import '../../../../core/init/service/firestorage/firestorage_initialize.dart';

abstract class IOwnerProductListService {
  Future<ObservableList<ProductDetailModel>?> fetchProductFirstList(
      String shopId);
  Future<ObservableList<ProductDetailModel>?> fetchProductMoreList(
    String shopId,
  );
  Future<void> deleteProductItem({required String productId});

  late DocumentSnapshot lastDocument;
}

class OwnerProductListService extends IOwnerProductListService {
  @override
  Future<ObservableList<ProductDetailModel>?> fetchProductFirstList(
      String shopId) async {
    ObservableList<ProductDetailModel> productList =
        ObservableList<ProductDetailModel>();

    final productListQuery = await FirebaseCollectionRefInitialize
        .instance.productsCollectionReference
        .where("shopId", isEqualTo: shopId)
        .limit(10)
        .get();

    List<DocumentSnapshot> docsInShops = productListQuery.docs;
    for (var element in docsInShops) {
      productList.add(ProductDetailModel.fromJson(element.data() as Map));
    }
    lastDocument = docsInShops.last;
    return productList;
  }

  @override
  Future<ObservableList<ProductDetailModel>?> fetchProductMoreList(
    String shopId,
  ) async {
    ObservableList<ProductDetailModel> productList =
        ObservableList<ProductDetailModel>();

    final productListQuery = await FirebaseCollectionRefInitialize
        .instance.productsCollectionReference
        .where("shopId", isEqualTo: shopId)
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
  Future<void> deleteProductItem({required String productId}) async {
    await FirebaseCollectionRefInitialize.instance.productsCollectionReference
        .doc(productId)
        .delete();
  }
}

/*
class OwnerProductListService extends IOwnerProductListService {
  @override
  Future<List<ProductDetailModel>?> fetchProductList(String shopId) async {
    List<ProductDetailModel> productList = [];
    final completer = Completer<List<ProductDetailModel>>();
      
    Query productListQuery = FirebaseCollectionRefInitialize
        .instance.productsCollectionReference
        .where("shopId", isEqualTo: "123456");
    final stream = productListQuery.snapshots().listen((event) {
      List<DocumentSnapshot> productDoctSnapshot = event.docs;
      for (var element in productDoctSnapshot) {
        productList.add(ProductDetailModel.fromJson(element.data() as Map));
      }
      completer.complete(productList);
    });
    return completer.future;
  }
}

*/

/*

Query query = productsCollectionReference.where("name", isEqualTo: "Kalem");
  query.snapshots().listen((event) {
    DocumentSnapshot x = event.docs.first;
    ProductDetailModel productDetailModel =
        ProductDetailModel.fromJson(x.data() as Map);
    print("***"+productDetailModel.name.toString());
  });

  */
    

 