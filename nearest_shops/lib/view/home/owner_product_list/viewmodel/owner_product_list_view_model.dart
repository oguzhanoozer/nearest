import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/product_detail_view_arg.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/base/route/generate_route.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/firestorage/user_location_initialize_check.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/image/image_network.dart';
import '../../../product/shop_product_view/product_list_view.dart';
import '../../dashboard/service/IDashboard_service.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../../product_detail/view/product_detail_view.dart';
import '../../shop_list/model/shop_model.dart';
import '../service/IOwner_product_list_service.dart';

part 'owner_product_list_view_model.g.dart';

class OwnerProductListViewModel = _OwnerProductListViewModelBase with _$OwnerProductListViewModel;

abstract class _OwnerProductListViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  ScrollController myscrollController = ScrollController();

  late IDashboardService dashboardService;

  ObservableList<String> userFavouriteList = ObservableList<String>();

  @observable
  bool isShopMapLoading = false;

  @observable
  bool isShopProductLoading = false;

  Set<Marker> _markerList = <Marker>{};
  List<ShopModel> _shopModelList = [];
  List<ProductDetailModel> _productsModelList = [];

  final double _originLatitude = 40.30;
  final double _originLongitude = 30.30;

  late final GeoPoint _geoPoint;

  late CameraPosition initalCameraPosition;

  @observable
  GoogleMapController? newGoogleMapController;

  late IOwnerProductListService ownerProductListService;

  TextEditingController searcpInputTExtFieldController = TextEditingController();

  late ShopModel _currentShopModel;

  @action
  void changeIsShopMapLoading() {
    isShopMapLoading = !isShopMapLoading;
  }

  @action
  void changeIsShopProductLoading() {
    isShopProductLoading = !isShopProductLoading;
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
    ownerProductListService = OwnerProductlistService(scaffoldState, context);
    dashboardService = DashboardService(scaffoldState, context);
  }

  @override
  Future<void> init({bool isDirection = false, ShopModel? shopModel}) async {
    changeIsShopMapLoading();

    if (isDirection) {
      if (shopModel != null && shopModel.location != null) {
        _geoPoint = GeoPoint(shopModel.location!.latitude, shopModel.location!.longitude);
      } else {
        _geoPoint = await UserLocationInitializeCheck.instance.returnUserLocation(scaffoldState, context!) ?? GeoPoint(_originLatitude, _originLongitude);
      }
    } else {
      _geoPoint = await UserLocationInitializeCheck.instance.returnUserLocation(scaffoldState, context!) ?? GeoPoint(_originLatitude, _originLongitude);
    }

    initalCameraPosition = CameraPosition(
      target: LatLng(_geoPoint.latitude, _geoPoint.longitude),
      zoom: 8,
    );

    userFavouriteList = (await UserLocationInitializeCheck.instance.getUserFavouriteList(scaffoldState, context!).asObservable())!;
    fetchShopsLocation();
  }

  List<ShopModel> filterShopList(String query) => List.of(_shopModelList).where((shop) {
        final shopLower = shop.name!.toLowerCase();
        final queryLower = query.toLowerCase();

        return shopLower.contains(queryLower);
      }).toList();

  @action
  void changeCameraPosition(GeoPoint geoPoint) {
    newGoogleMapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(geoPoint.latitude, geoPoint.longitude), zoom: 8)));
  }

  Future<void> fetchShopsLocation() async {
    List<DocumentSnapshot>? docsInShops = await ownerProductListService.fetchDocsInShops();
    if (docsInShops != null && docsInShops.isNotEmpty) {
      for (var element in docsInShops) {
        ShopModel shopModel = ShopModel.fromJson(element.data() as Map);
        _shopModelList.add(shopModel);

        addMarker(shopModel);
      }
    }

    changeIsShopMapLoading();
  }

  @action
  Future<void> changeFavouriteList(String productId) async {
    if (userFavouriteList.contains(productId)) {
      await dashboardService.removeItemToFavouriteList(productId);
      userFavouriteList.remove(productId);
    } else {
      await dashboardService.addItemToFavouriteList(productId);
      userFavouriteList.add(productId);
    }
  }

  @action
  void addMarker(ShopModel shopModel) {
    String markerIdVal = shopModel.name!;
    final MarkerId markerId = MarkerId(markerIdVal);

    if (shopModel.location != null) {
      Marker marker = Marker(
        markerId: markerId,
        position: LatLng(shopModel.location!.latitude, shopModel.location!.longitude),
        draggable: false,
        infoWindow: InfoWindow(title: markerIdVal),
        onTap: () async {
          fetchShopProducts(shopId: shopModel.id!);
          showDialog(
              barrierDismissible: false,
              context: context!,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: context.normalBorderRadius / 2),
                  content: Observer(builder: (_) {
                    return Stack(
                      fit: StackFit.loose,
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Observer(builder: (_) {
                          return Container(
                            height: context.dynamicHeight(0.9),
                            width: context.dynamicWidth(0.9),
                            decoration: buildBoxDecoration(context),
                            child: isShopProductLoading ? Center(child: CallCircularProgress(context)) : buildProductListView(myscrollController, context),
                          );
                        }),
                        Positioned(
                          right: -8.0,
                          top: -8.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                                child: Icon(Icons.close, color: context.colorScheme.inversePrimary),
                                radius: context.normalValue,
                                backgroundColor: context.colorScheme.onSurfaceVariant),
                          ),
                        ),
                      ],
                    );
                  }),
                );
              });
        },
      );

      _markerList.add(marker);
    }
  }

  BoxDecoration buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(context.normalValue)),
      color: context.colorScheme.background,
      gradient: LinearGradient(
        colors: [
          context.colorScheme.background,
          context.colorScheme.background,
          context.colorScheme.background,
          context.colorScheme.onSurfaceVariant.withOpacity(0.5)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [
          0.1,
          0.3,
          0.6,
          0.9,
        ],
      ),
    );
  }

  Widget buildProductListView(
    ScrollController myscrollController,
    BuildContext context,
  ) {
    return Padding(
      padding: context.paddingLow,
      child: Observer(builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      getShopModel().name!,
                      style: GoogleFonts.concertOne(
                          textStyle: context.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.onSurfaceVariant)),
                    ),
                    context.emptySizedHeightBoxLow3x,
                    Text(
                      LocaleKeys.emailText.locale + getShopModel().email!,
                      style:
                          GoogleFonts.lora(textStyle: context.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, color: context.colorScheme.primary)),
                    ),
                    context.emptySizedHeightBoxLow,
                    Text(
                      LocaleKeys.noText.locale + " :" + getShopModel().phoneNumber!,
                      style:
                          GoogleFonts.lora(textStyle: context.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, color: context.colorScheme.primary)),
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    height: context.dynamicHeight(0.1),
                    width: context.dynamicWidth(0.1),
                    child: getShopModel().logoUrl!.isEmpty ? shopDefaultLottie(context) : buildImageNetwork(getShopModel().logoUrl ?? "", context),
                  ),
                ),
              ],
            ),
            context.emptySizedHeightBoxLow,
            Text(
              LocaleKeys.addressText.locale + " :" + getShopModel().address!,
              style: GoogleFonts.lora(textStyle: context.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500, color: context.colorScheme.primary)),
            ),
            context.emptySizedHeightBoxLow,
            Divider(
              thickness: 0.5,
              color: context.colorScheme.primary,
            ),
            Expanded(
              child: Observer(builder: (_) {
                return ListView.builder(
                  controller: myscrollController,
                  itemCount: getListProductDetailModel().length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildProductCard(context, getListProductDetailModel()[index]);
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }

  Widget buildProductCard(BuildContext context, ProductDetailModel productDetailModel) {
    return Observer(builder: (_) {
      return GestureDetector(
        onTap: (() => Navigator.pushNamed(context, productDetailViewRoute,
            arguments: ProductDetailViewArguments(
              productDetailModel,
              false,
            ))),
        child: ShopProductView(
          productDetailModel: productDetailModel,
          shopModel: null,
          rightSideWidget: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              iconSize: 30,
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.favorite,
                color: favIconCheck(productDetailModel, context),
              ),
              onPressed: () async {
                await changeFavouriteList(productDetailModel.productId.toString());
              },
            ),
          ]),
        ),
      );
    });
  }

  Color favIconCheck(ProductDetailModel productDetailModel, BuildContext context) {
    return userFavouriteList.contains(productDetailModel.productId) ? context.colorScheme.onPrimaryContainer : context.colorScheme.surface;
  }

  @action
  Future<void> fetchShopProducts({required String shopId}) async {
    changeIsShopProductLoading();
    _productsModelList = await ownerProductListService.fethcProductListModel(shopId: shopId) ?? [];
    _currentShopModel = _shopModelList.firstWhere((element) => element.id == shopId);

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

  ShopModel getShopModel() {
    return _currentShopModel;
  }
}
