import 'package:cloud_firestore/cloud_firestore.dart';

import '../../comment/model/product_comment_model.dart';

class ProductDetailModel {
  String? name;
  String? summary;
  String? detail;
  num? price;
  DateTime? lastSeenDate;
  List<String>? imageUrlList;
  String? shopId;
  String? productId;
  int? categoryId;
  List<String>? imageStoreNameList;
  List<ProductCommentModel>? comments;

  ProductDetailModel(
      {this.name,
      this.detail,
      this.imageUrlList,
      this.lastSeenDate,
      this.price,
      this.productId,
      this.summary,
      this.shopId,
      this.categoryId,
      this.imageStoreNameList,
      this.comments});

  Map<String, dynamic> toMap() => {
        "name": name,
        "detail": detail,
        "imageUrlList": imageUrlList,
        "lastSeenDate": lastSeenDate,
        "price": price,
        "productId": productId,
        "summary": summary,
        "shopId": shopId,
        "categoryId": categoryId,
        "imageStoreNameList": imageStoreNameList,
        "productCommentList": comments
      };

  factory ProductDetailModel.fromJson(Map map) => ProductDetailModel(
        name: map["name"],
        detail: map["detail"],
        imageUrlList: List<String>.from(map["imageUrlList"] ??= []),
        lastSeenDate: (map["lastSeenDate"] as Timestamp).toDate(),
        price: map["price"],
        productId: map["productId"],
        summary: map["summary"],
        shopId: map["shopId"],
        categoryId: map["categoryId"],
        comments: List<ProductCommentModel>.from((map["comments"] ?? [])
                .map((e) => ProductCommentModel.fromJson(e))
                .toList() ??
            []),
        imageStoreNameList: List<String>.from(map["imageStoreNameList"] ??= []),
      );
}
