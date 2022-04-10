import 'dart:math' show cos, sqrt, asin;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/base_view_model.dart';
import 'package:nearest_shops/view/home/shop_list/service/IShop_list_service.dart';

import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../../core/init/service/firestorage/user_location_initialize_check.dart';
import '../model/shop_model.dart';

part 'shop_list_view_model.g.dart';

class ShopListViewModel = _ShopListViewModelBase with _$ShopListViewModel;

abstract class _ShopListViewModelBase with Store, BaseViewModel {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @observable
  bool isShopMapListLoading = false;

  List<ShopModel> _shopModelList = [];
  late final GeoPoint _geoPoint;
  late IShopListService shopListService;

  @action
  void changeIsShopMapListLoading() {
    isShopMapListLoading = !isShopMapListLoading;
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
    shopListService = ShopListService(scaffoldState, context);
  }

  @override
  Future<void> init() async {
    _geoPoint =
        (await UserLocationInitializeCheck.instance.returnUserLocation())!;
    fetchShopsLocation();
  }

  Future<void> fetchShopsLocation() async {
    changeIsShopMapListLoading();
    _shopModelList = await shopListService.fetchShopList() ?? [];
    if (_shopModelList.isNotEmpty) {
      _shopModelList.sort(((a, b) => calculateDistance(_geoPoint.latitude,
              _geoPoint.longitude, a.location!.latitude, a.location!.longitude)
          .compareTo(calculateDistance(_geoPoint.latitude, _geoPoint.longitude,
              b.location!.latitude, b.location!.longitude))));
    }
    changeIsShopMapListLoading();
  }

  double calculateDistance(latitude1, longtitude1, latitude2, longtitude2) {
    var p = 0.017453292519943295;
    var cosConstant = cos;
    var a = 0.5 -
        cosConstant((latitude2 - latitude1) * p) / 2 +
        cosConstant(latitude1 * p) *
            cosConstant(latitude2 * p) *
            (1 - cosConstant((longtitude2 - longtitude1) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  List<ShopModel> getListShopModel() {
    return _shopModelList;
  }
}
