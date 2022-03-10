import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
  String? name;
  String? address;
  String? logoUrl;
  String? id;
  GeoPoint? location;

  ShopModel({this.id, this.name, this.address, this.logoUrl, this.location});

  Map<String, dynamic> toMap() => {
        "name": name,
        "address": address,
        "logoUrl": logoUrl,
        "location": location,
        "id": id,
      };

  factory ShopModel.fromJson(Map map) => ShopModel(
      name: map["name"],
      address: map["address"],
      logoUrl: map["logoUrl"],
      location: map["location"],
      id: map["id"]);
}
