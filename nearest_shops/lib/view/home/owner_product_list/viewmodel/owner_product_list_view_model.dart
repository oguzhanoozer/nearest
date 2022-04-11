import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/service/firestorage/user_location_initialize_check.dart';
import '../../../product/product_list_view/product_list_view.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../../shop_list/model/shop_model.dart';
import '../service/IOwner_product_list_service.dart';

part 'owner_product_list_view_model.g.dart';

class OwnerProductListViewModel = _OwnerProductListViewModelBase
    with _$OwnerProductListViewModel;

abstract class _OwnerProductListViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @observable
  bool isShopMapLoading = false;

  @observable
  bool isShopProductLoading = false;

  @observable
  bool isShopProductDraggleLoaded = false;

  Set<Marker> _markerList = <Marker>{};
  List<ShopModel> _shopModelList = [];
  List<ProductDetailModel> _productsModelList = [];

  final double _originLatitude = 40.30;
  final double _originLongitude = 30.30;

  late final GeoPoint _geoPoint;
  late CameraPosition initalCameraPosition;

  late IOwnerProductListService ownerProductListService;

  late String _shopName;

  @action
  void changeIsShopMapLoading() {
    isShopMapLoading = !isShopMapLoading;
  }

  @action
  void changeIsShopProductLoading() {
    isShopProductLoading = !isShopProductLoading;
  }

  @action
  void changeIsShopProductLoaded(bool value) {
    isShopProductDraggleLoaded = value;
  }

  void setContext(BuildContext context) {
    this.context = context;
    ownerProductListService = OwnerProductlistService(scaffoldState, context);
  }

  @override
  Future<void> init() async {
    changeIsShopMapLoading();
    _geoPoint =
        await UserLocationInitializeCheck.instance.returnUserLocation() ??
            GeoPoint(_originLatitude, _originLongitude);

    initalCameraPosition = CameraPosition(
      target: LatLng(_geoPoint.latitude, _geoPoint.longitude),
      zoom: 8,
    );
    fetchShopsLocation();
  }

  Future<void> fetchShopsLocation() async {
    List<DocumentSnapshot>? docsInShops =
        await ownerProductListService.fetchDocsInShops();
    if (docsInShops != null && docsInShops.isNotEmpty) {
      for (var element in docsInShops) {
        ShopModel shopModel = ShopModel.fromJson(element.data() as Map);
        _shopModelList.add(shopModel);

        addMarker(shopModel);
      }
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
        showModalBottomSheet(
            isDismissible: true,
            isScrollControlled: true,
            context: context!,
            backgroundColor: Colors.transparent,
            builder: (context) => AnimatedCrossFade(
                  duration: Duration(milliseconds: 1000),
                  reverseDuration: Duration(milliseconds: 600),
                  crossFadeState: isShopProductDraggleLoaded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Container(),
                  secondChild: buildDraggeableContainer(),
                ));
      },
    );

    _markerList.add(marker);
  }

  Widget makeDismissble(
      {required Widget child, required BuildContext context}) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          changeIsShopProductLoaded(false);
          Navigator.of(context).pop();
        },
        child: child);
  }

  Widget buildDraggeableContainer() {
    return makeDismissble(
      context: context!,
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (DraggableScrollableNotification DSNotification) {
          //if (DSNotification.extent >= 0.2) {
          //  changeIsShopProductLoaded();
          //  print("oguzhan");
          //}
          // else
          if (DSNotification.extent < 0.2) {
            changeIsShopProductLoaded(false);
          }
          return false;
        },
        child: DraggableScrollableSheet(
          initialChildSize: 0.3,
          maxChildSize: 0.8,
          minChildSize: 0.0,
          snap: true,
          //expand: false,
          builder: (BuildContext context, myscrollController) {
            return Padding(
              padding: context.horizontalPaddingLow,
              child: Container(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSecondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(context.normalValue),
                    topRight: Radius.circular(context.normalValue),
                  ),
                ),
                child: isShopProductLoading
                    ? Center(child: CircularProgressIndicator())
                    : buildProductListView(myscrollController, context),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildProductListView(
    ScrollController myscrollController,
    BuildContext context,
  ) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getShopName(),
            style: context.textTheme.headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              controller: myscrollController,
              itemCount: getListProductDetailModel().length,
              itemBuilder: (BuildContext context, int index) {
                return buildProductCard(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductCard(BuildContext context, int index) {
    return ProductListView(
      index: index,
      productDetailModel: getListProductDetailModel()[index],
      shopModel: null,
      rightSideWidget:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        IconButton(
          iconSize: 30,
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: null,
        ),
      ]),
    );
  }

  @action
  Future<void> fetchShopProducts({required String shopId}) async {
    changeIsShopProductLoading();
    _productsModelList =
        await ownerProductListService.fethcProductListModel(shopId: shopId) ??
            [];
    _shopName =
        _shopModelList.firstWhere((element) => element.id == shopId).name!;
    changeIsShopProductLoaded(true);
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

  String getShopName() {
    return _shopName;
  }
}
