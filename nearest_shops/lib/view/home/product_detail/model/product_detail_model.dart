import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailModel {
  String? name;
  String? summary;
  String? detail;
  double? price;
  DateTime? lastSeenDate;
  List<String>? imageUrlList;
  String? shopId;
  String? productId;

  ProductDetailModel(
      {this.name,
      this.detail,
      this.imageUrlList,
      this.lastSeenDate,
      this.price,
      this.productId,
      this.summary,
      this.shopId});

  Map<String, dynamic> toMap() => {
        "name": name,
        "detail": detail,
        "imageUrlList": imageUrlList,
        "lastSeenDate": lastSeenDate,
        "price": price,
        "productId": productId,
        "summary": summary,
        "shopId": shopId
      };

  factory ProductDetailModel.fromJson(Map map) => ProductDetailModel(
        name: map["name"],
        detail: map["detail"],
        imageUrlList: List<String>.from(map["imageUrlList"]),
        lastSeenDate: (map["lastSeenDate"] as Timestamp).toDate(),
        price: map["price"],
        productId: map["productId"],
        summary: map["summary"],
        shopId: map["shopId"],
      );
}
