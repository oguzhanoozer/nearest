import 'dart:math' show cos, sqrt, asin;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/base_view_model.dart';

import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../../core/init/service/firestorage/user_location_initialize_check.dart';
import '../model/shop_model.dart';

part 'shop_list_view_model.g.dart';

class ShopListViewModel = _ShopListViewModelBase with _$ShopListViewModel;

abstract class _ShopListViewModelBase with Store, BaseViewModel {
  @observable
  bool isShopMapListLoading = false;

  List<ShopModel> _shopModelList = [];
  late final GeoPoint _geoPoint;

  @action
  void changeIsShopMapListLoading() {
    isShopMapListLoading = !isShopMapListLoading;
  }

  void setContext(BuildContext context) {}
  Future<void> init() async {
    _geoPoint =
        (await UserLocationInitializeCheck.instance.returnUserLocation())!;
    fetchShopsLocation();
  }

  Future<void> fetchShopsLocation() async {
    changeIsShopMapListLoading();
    final shopsListQuery = await FirebaseCollectionRefInitialize
        .instance.shopsCollectionReference
        .get();

    List<DocumentSnapshot> docsInShops = shopsListQuery.docs;
    if (docsInShops.isNotEmpty) {
      for (var element in docsInShops) {
        ShopModel shopModel = ShopModel.fromJson(element.data() as Map);
        _shopModelList.add(shopModel);
      }
    }

    _shopModelList.sort(((a, b) => calculateDistance(_geoPoint.latitude,
            _geoPoint.longitude, a.location!.latitude, a.location!.longitude)
        .compareTo(calculateDistance(_geoPoint.latitude, _geoPoint.longitude,
            b.location!.latitude, b.location!.longitude))));

    changeIsShopMapListLoading();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  List<ShopModel> getListShopModel() {
    return _shopModelList;
  }
}
