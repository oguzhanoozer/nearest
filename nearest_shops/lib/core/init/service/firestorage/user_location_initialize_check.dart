import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';
import 'package:nearest_shops/core/init/service/firestorage/enum/document_collection_enums.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import '../../../../view/authentication/login/model/user_model.dart';
import '../../lang/locale_keys.g.dart';
import '../authenticaion/user_id_initialize.dart';
import 'firestorage_initialize.dart';

class UserLocationInitializeCheck with ErrorHelper {
  static UserLocationInitializeCheck _instance = UserLocationInitializeCheck._init();
  UserLocationInitializeCheck._init();
  static UserLocationInitializeCheck get instance => _instance;

  GeoPoint? _userLocation;

  late bool serviceEnabled;
  late LocationPermission permission;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<ObservableList<String>?> getUserFavouriteList(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) async {
    ObservableList<String> _favouriteList = ObservableList<String>();
    final userId = await UserIdInitalize.instance.returnUserId(scaffoldState, context);

    final userQuery = await FirebaseCollectionRefInitialize.instance.usersCollectionReference.where(ContentString.ID.rawValue, isEqualTo: userId).get();

    List<DocumentSnapshot> userDocs = userQuery.docs;

    if (userDocs.isNotEmpty) {
      UserModel userModel = UserModel.fromJson(userDocs.first.data() as Map);
      _favouriteList = userModel.favouriteList!.asObservable();
      return _favouriteList;
    }
  }

  Future<void> assignUserLocation(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) async {
    if (_userLocation == null) {
      final geoPoint = await _fetchUserLocation(scaffoldState, context);
      if (geoPoint == null) {
        await gerCurrentLocationPosition(scaffoldState, context);
      }
    }
  }

  void setUserLocation(GeoPoint geoPoint) {
    _userLocation = geoPoint;
  }

  Future<GeoPoint?> returnUserLocation(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) async {
    if (_userLocation == null) {
      await assignUserLocation(scaffoldState, context);
    }
    return _userLocation;
  }

  void setLocation(GeoPoint shopLocation) {
    _userLocation = shopLocation;
  }

  Future<GeoPoint?> _fetchUserLocation(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) async {
    try {
      final userId = await UserIdInitalize.instance.returnUserId(scaffoldState, context);

      final userQuery = await FirebaseCollectionRefInitialize.instance.usersCollectionReference.where(ContentString.ID.rawValue, isEqualTo: userId).get();

      List<DocumentSnapshot> userDocs = userQuery.docs;

      if (userDocs.isNotEmpty) {
        UserModel userModel = UserModel.fromJson(userDocs.first.data() as Map);
        _userLocation = userModel.location;
        return _userLocation;
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }

  @action
  Future<Position?> getLocationPermission(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) async {
    Position? position;
    try {
      serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
      if (!serviceEnabled) {}
      permission = await _geolocatorPlatform.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await _geolocatorPlatform.requestPermission();
      }

      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      return position;
    } catch (e) {
      setLocation(GeoPoint(42, 32));
      showSnackBar(scaffoldState, context, "Konum bilgisine erişilemedi.Konum erişimine izin vererek, daha yakın yerleri görebilirsiniz", timeIsLong: true);
    }
  }

  Future<void> gerCurrentLocationPosition(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) async {
    try {
      Position? position = await getLocationPermission(scaffoldState, context);
      if (position != null) {
        _userLocation = GeoPoint(position.latitude, position.longitude);

        final userId = await UserIdInitalize.instance.returnUserId(scaffoldState, context);

        Map<String, dynamic> locationMap = {ContentString.LOCATION.rawValue: GeoPoint(position.latitude, position.longitude)};

        await FirebaseCollectionRefInitialize.instance.usersCollectionReference.doc(userId).update(locationMap);
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.loginError.locale);
    }
  }
}
