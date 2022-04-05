import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  GeoPoint? location;
  int? role;
  List<String>? favouriteList;

  UserModel({this.id, this.location, this.role, this.favouriteList});

  Map<String, dynamic> toMap() => {
        "location": location,
        "id": id,
        "role": role,
        "favouriteList": favouriteList
      };

  factory UserModel.fromJson(Map map) => UserModel(
      id: map["id"],
      location: map["location"],
      role: map["role"],
      favouriteList: List<String>.from(map["favouriteList"]));
}
