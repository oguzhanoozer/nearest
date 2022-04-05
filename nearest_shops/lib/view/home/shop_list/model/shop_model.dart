import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
  String? name;
  String? address;
  String? logoUrl;
  String? id;
  GeoPoint? location;
  String? phoneNumber;
  String? email;

  ShopModel({this.id, this.name, this.address, this.logoUrl, this.location,this.email,this.phoneNumber});

  Map<String, dynamic> toMap() => {
        "name": name,
        "address": address,
        "logoUrl": logoUrl,
        "location": location,
        "id": id,
        "email": email,
        "phoneNumber": phoneNumber,
      };

  factory ShopModel.fromJson(Map map) => ShopModel(
      name: map["name"],
      address: map["address"],
      logoUrl: map["logoUrl"],
      location: map["location"],
      id: map["id"],
      email: map["email"],
      phoneNumber: map["phoneNumber"],);
}
