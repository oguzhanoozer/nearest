import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/base_view_model.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';

import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../../core/init/service/firestorage/user_location_initialize_check.dart';
import '../../../product/contstants/image_path.dart';
import '../../dashboard/model/dashboard_model.dart';
import '../../shop_list/model/shop_model.dart';

part 'owner_product_list_view_model.g.dart';

class OwnerProductListViewModel = _OwnerProductListViewModelBase
    with _$OwnerProductListViewModel;

abstract class _OwnerProductListViewModelBase with Store, BaseViewModel {
  @observable
  bool isShopMapLoading = false;

  @observable
  bool isShopProductLoading = false;

  @observable
  bool isShopProductLoaded = false;

  Set<Marker> _markerList = <Marker>{};
  List<ShopModel> _shopModelList = [];
  List<ProductDetailModel> _productsModelList = [];

  final double _originLatitude = 40.30;
  final double _originLongitude = 30.30;

  late final GeoPoint _geoPoint;

  CameraPosition? initalCameraPosition;

  @action
  void changeIsShopMapLoading() {
    isShopMapLoading = !isShopMapLoading;
  }

  @action
  void changeIsShopProductLoading() {
    isShopProductLoading = !isShopProductLoading;
  }

  @action
  void changeIsShopProductLoaded() {
    isShopProductLoaded = !isShopProductLoaded;
  }

  void setContext(BuildContext context) {}
  @override
  Future<void> init() async {
    _geoPoint =
        (await UserLocationInitializeCheck.instance.returnUserLocation())!;

    initalCameraPosition = CameraPosition(
      target: LatLng(_geoPoint.latitude, _geoPoint.longitude),
      zoom: 10,
    );
    fetchShopsLocation();
  }

  Future<void> fetchShopsLocation() async {
    changeIsShopMapLoading();
    final shopsListQuery = await FirebaseCollectionRefInitialize
        .instance.shopsCollectionReference
        .get();

    List<DocumentSnapshot> docsInShops = shopsListQuery.docs;
    for (var element in docsInShops) {
      ShopModel shopModel = ShopModel.fromJson(element.data() as Map);
      _shopModelList.add(shopModel);

      addMarker(shopModel);
    }
    changeIsShopMapLoading();
  }

  void addMarker(ShopModel shopModel) {
    String markerIdVal = shopModel.name!;
    final MarkerId markerId = MarkerId(markerIdVal);

    Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(shopModel.location!.latitude, shopModel.location!.longitude),
      draggable: false,
      infoWindow: InfoWindow(title: markerIdVal),
      onTap: () async {
        await fetchShopProducts(shopId: shopModel.id!);
      },
    );

    _markerList.add(marker);
  }

  Future<void> fetchShopProducts({required String shopId}) async {
    changeIsShopProductLoading();

    final productListQuery = await FirebaseCollectionRefInitialize
        .instance.productsCollectionReference
        .where("shopId", isEqualTo: shopId)
        .limit(10)
        .get();

    List<DocumentSnapshot> productDocsInShops = productListQuery.docs;
    for (var element in productDocsInShops) {
      _productsModelList
          .add(ProductDetailModel.fromJson(element.data() as Map));
    }
    changeIsShopProductLoaded();
    changeIsShopProductLoading();
  }

  List<ProductDetailModel> getListProductDetailModel() {
    return _productsModelList;
  }

  List<ShopModel> getListShopModel() {
    return _shopModelList;
  }

  Set<Marker> getListMarkerList() {
    return _markerList;
  }
}
