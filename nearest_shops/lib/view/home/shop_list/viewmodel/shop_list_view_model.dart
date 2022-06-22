import 'dart:math' show cos, sqrt, asin;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/base/model/home_dashboard_navigation_arg.dart';
import '../../../../core/base/route/generate_route.dart';
import '../../../../core/init/service/firestorage/user_location_initialize_check.dart';
import '../../../ads/add_helper_view.dart';
import '../../dashboard/view/home_dashboard_navigation_view.dart';
import '../model/shop_model.dart';
import '../service/IShop_list_service.dart';

part 'shop_list_view_model.g.dart';

class ShopListViewModel = _ShopListViewModelBase with _$ShopListViewModel;

abstract class _ShopListViewModelBase with Store, BaseViewModel {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @observable
  bool isShopMapListLoading = false;

  @observable
  bool isSearching = false;

  List<ShopModel> _shopModelList = [];

  late final GeoPoint _geoPoint;
  late IShopListService shopListService;

  @observable
  ObservableList<ShopModel> shopModelList = ObservableList<ShopModel>();

  @observable
  ObservableList<ShopModel> _shopPersistModelList = ObservableList<ShopModel>();

  late InterstitialAd? interstitialAd;

  bool isInterstitialAdReady = false;

  late ShopModel paramShopModel;

  void _initAdd() {
    InterstitialAd.load(
      adUnitId: AddHelperView.interstitialAddUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isInterstitialAdReady = true;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Navigator.pushNamed(context!, homeNavigationDashboardViewRoute,
                  arguments: HomeDashboardNavigationArg(
                    paramShopModel,
                    isDirection: true,
                  ));
            },
          );
        },
        onAdFailedToLoad: (err) {
          isInterstitialAdReady = false;
        },
      ),
    );
  }

  @action
  void changeIsSearching() {
    isSearching = !isSearching;

    if (isSearching == false) {
      shopModelList = _shopPersistModelList;
    }
  }

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
    _geoPoint = (await UserLocationInitializeCheck.instance.returnUserLocation(scaffoldState, context!))!;
    fetchShopsLocation();
    _initAdd();
  }

  Future<void> fetchShopsLocation() async {
    changeIsShopMapListLoading();
    var tempNullLocationList = [];
    shopModelList = (await shopListService.fetchShopList())!.asObservable();
    if (shopModelList.isNotEmpty) {
      for (var element in shopModelList) {
        if (element.location == null) {
          tempNullLocationList.add(element);
        }
      }

      for (var element in tempNullLocationList) {
        shopModelList.remove(element);
      }

      shopModelList.sort(((a, b) => calculateDistance(_geoPoint.latitude, _geoPoint.longitude, a.location?.latitude, a.location?.longitude)
          .compareTo(calculateDistance(_geoPoint.latitude, _geoPoint.longitude, b.location?.latitude, b.location?.longitude))));
    }
    _shopPersistModelList = shopModelList;
    changeIsShopMapListLoading();
  }

  double calculateDistance(latitude1, longtitude1, latitude2, longtitude2) {
    var p = 0.017453292519943295;
    var cosConstant = cos;
    var a = 0.5 -
        cosConstant((latitude2 - latitude1) * p) / 2 +
        cosConstant(latitude1 * p) * cosConstant(latitude2 * p) * (1 - cosConstant((longtitude2 - longtitude1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @action
  void filterProducts(String productName) {
    shopModelList = shopModelList.where((item) => item.name!.toLowerCase().contains(productName..toLowerCase())).toList().asObservable();
  }

  List<ShopModel> getListShopModel() {
    return _shopModelList;
  }
}
