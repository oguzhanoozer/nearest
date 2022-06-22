import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearest_shops/core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../home/shop_list/model/shop_model.dart';
import '../../../utility/error_helper.dart';

import '../../../../core/init/service/firestorage/firestorage_initialize.dart';

abstract class IUserChangeLocationService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IUserChangeLocationService(this.scaffoldState, this.context);

  Future<void> updateShopLocation(GeoPoint geoPoint);
}

class UserChangeLocationService extends IUserChangeLocationService with ErrorHelper {
  UserChangeLocationService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) : super(scaffoldState, context);

  Future<void> updateShopLocation(GeoPoint geoPoint) async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();
      if (user != null) {
        Map<String, dynamic> updateGeoPointData = {ContentString.LOCATION.rawValue: geoPoint};

        await FirebaseCollectionRefInitialize.instance.usersCollectionReference.doc(user.uid).update(updateGeoPointData);
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.errorOnUpdateLocationText.locale);
    }
  }
}
