import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/user_location_initialize_check.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../service/IDashboard_service.dart';

part 'dashboard_view_model.g.dart';

class DashboardViewModel = _DashboardViewModelBase with _$DashboardViewModel;

enum Sorting { SUGGEST_ORDER, DECREASE_PRICE, INCREASE_PRICE }

abstract class _DashboardViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  ScrollController? controller;

  late bool serviceEnabled;
  late LocationPermission permission;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @observable
  bool isProductFirstListLoading = false;

  @observable
  bool isProductMoreListLoading = false;

  @observable
  bool isProductSliderListLoading = false;

  late IDashboardService dashboardService;

  TextEditingController searcpInputTExtFieldController = TextEditingController();

  @observable
  bool isSearching = false;

  List<String> menuItems = [LocaleKeys.aShopText.locale, LocaleKeys.addNewProductText.locale, LocaleKeys.createBusinessAccountButtonText.locale];

  @action
  void changeIsSearching(bool value) {
    isSearching = value;
    if (isSearching == false) {
      productList = persistProductList;
    }
  }

  @observable
  ObservableList<ProductDetailModel> productList = ObservableList<ProductDetailModel>();

  @observable
  ObservableList<ProductDetailModel> persistProductList = ObservableList<ProductDetailModel>();

  @override
  List<ProductDetailModel> _productSliderList = [];

  ObservableList<String> userFavouriteList = ObservableList<String>();

  late final String shopId;

  @observable
  String filterText = "";

  @override
  void setContext(BuildContext context) {
    this.context = context;
    dashboardService = DashboardService(scaffoldState, context);
  }

  @override
  void init() {
    checkUserLocation();
    FocusScope.of(context!).unfocus();
  }

  @action
  void changeIsProductFirstListLoading() {
    isProductFirstListLoading = !isProductFirstListLoading;
  }

  @action
  void changeIsProductMoreListLoading() {
    isProductMoreListLoading = !isProductMoreListLoading;
  }

  @action
  void changeIsProductSliderListLoading() {
    isProductSliderListLoading = !isProductSliderListLoading;
  }

  Future<void> checkUserLocation() async {
    await UserLocationInitializeCheck.instance.assignUserLocation(scaffoldState,context!);
    initializeState();
  }

  void initializeState() async {
    controller = ScrollController()
      ..addListener(() {
        if (controller!.position.extentAfter < 300) {
          fetchProductLastList();
        }
      });
    userFavouriteList = (await UserLocationInitializeCheck.instance.getUserFavouriteList(scaffoldState,context!).asObservable())!;
    fetchProductSliderList();
    fetchProductFirstList();
  }

  @action
  Future<void> fetchProductFirstList() async {
    changeIsProductFirstListLoading();
    String? shopId = await UserIdInitalize.instance.returnUserId(scaffoldState,context!);
    List<ProductDetailModel> _productList = shopId == null ? [] : await dashboardService.fetchDashboardProductFirstList() ?? [];

    productList = _productList.asObservable();
    persistProductList = productList;

    changeIsProductFirstListLoading();
  }

  @action
  void sortProductList(Sorting sortingOption) {
    if (sortingOption == Sorting.SUGGEST_ORDER) {
      productList.sort((ProductDetailModel dataA, ProductDetailModel dataB) => dataA.productId!.compareTo(dataB.productId!));
    } else if (sortingOption == Sorting.DECREASE_PRICE) {
      productList.sort((ProductDetailModel dataA, ProductDetailModel dataB) => dataB.price!.compareTo(dataA.price!));
    } else if (sortingOption == Sorting.INCREASE_PRICE) {
      productList.sort((ProductDetailModel dataA, ProductDetailModel dataB) => dataA.price!.compareTo(dataB.price!));
    }
  }

  @action
  Future<void> fetchProductLastList() async {
    if (isProductFirstListLoading == false && isProductMoreListLoading == false) {
      changeIsProductMoreListLoading();
      String? shopId = await UserIdInitalize.instance.returnUserId(scaffoldState,context!);
      List<ProductDetailModel> moreDataList = shopId == null ? [] : await dashboardService.fetchDashboardProductMoreList() ?? [];
      productList.addAll(moreDataList);

      persistProductList = productList;

      changeIsProductMoreListLoading();
    }
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
  Future<void> fetchProductSliderList() async {
    changeIsProductSliderListLoading();
    String? shopId = await UserIdInitalize.instance.returnUserId(scaffoldState,context!);
    _productSliderList = shopId == null ? [] : await dashboardService.fetchDashboardSliderList() ?? [];

    changeIsProductSliderListLoading();
  }

  List<ProductDetailModel> getProductSliderList() {
    return _productSliderList;
  }

  @action
  void filterProducts(String productName) {
    if (productName.isEmpty) {
      changeIsSearching(false);
    } else {
      changeIsSearching(true);
      productList = productList.where((item) => item.name!.toLowerCase().contains(productName..toLowerCase())).toList().asObservable();
    }
  }

  List<ProductDetailModel> filterProductList(String query) => List.of(productList).where((shop) {
        final productLower = shop.name!.toLowerCase();
        final queryLower = query.toLowerCase();

        return productLower.contains(queryLower);
      }).toList();
}
