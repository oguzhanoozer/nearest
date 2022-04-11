import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import '../../../../view/authentication/login/model/user_model.dart';
import '../../../../view/home/shop_list/model/shop_model.dart';

import '../authenticaion/user_id_initialize.dart';
import 'firestorage_initialize.dart';

class UserLocationInitializeCheck {
  static UserLocationInitializeCheck _instance =
      UserLocationInitializeCheck._init();
  UserLocationInitializeCheck._init();
  static UserLocationInitializeCheck get instance => _instance;

  GeoPoint? _userLocation;

  late bool serviceEnabled;
  late LocationPermission permission;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<void> assignUserLocation() async {
    if (_userLocation == null) {
      final geoPoint = await _fetchUserLocation();
      if (geoPoint == null) {
        await gerCurrentLocationPosition();
      }
    }
  }

  Future<ObservableList<String>?> getUserFavouriteList() async {
    ObservableList<String> _favouriteList = ObservableList<String>();
    final userId = await UserIdInitalize.instance.returnUserId();

    final userQuery = await FirebaseCollectionRefInitialize
        .instance.usersCollectionReference
        .where("id", isEqualTo: userId)
        .get();

    List<DocumentSnapshot> userDocs = userQuery.docs;

    if (userDocs.isNotEmpty) {
      UserModel userModel = UserModel.fromJson(userDocs.first.data() as Map);
      _favouriteList = userModel.favouriteList!.asObservable();
      return _favouriteList;
    }
  }

  Future<GeoPoint?> returnUserLocation() async {
    if (_userLocation == null) {
      await assignUserLocation();
    }
    return _userLocation;
  }

  void setLocation(GeoPoint shopLocation) {
    _userLocation = shopLocation;
  }

  Future<GeoPoint?> _fetchUserLocation() async {
    try {
      final userId = await UserIdInitalize.instance.returnUserId();

      final userQuery = await FirebaseCollectionRefInitialize
          .instance.usersCollectionReference
          .where("id", isEqualTo: userId)
          .get();

      List<DocumentSnapshot> userDocs = userQuery.docs;

      if (userDocs.isNotEmpty) {
        UserModel userModel = UserModel.fromJson(userDocs.first.data() as Map);
        _userLocation = userModel.location;
        // _favouriteList = userModel.favouriteList;
        return _userLocation;
      }
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }

  Future<Position> getLocationPermission() async {
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {}
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {}
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<void> gerCurrentLocationPosition() async {
    Position position = await getLocationPermission();
    _userLocation = GeoPoint(position.latitude, position.longitude);

    final userId = await UserIdInitalize.instance.returnUserId();

    Map<String, dynamic> locationMap = {
      "location": GeoPoint(position.latitude, position.longitude)
    };

    try {
      await FirebaseCollectionRefInitialize.instance.usersCollectionReference
          .doc(userId)
          .update(locationMap);
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}
