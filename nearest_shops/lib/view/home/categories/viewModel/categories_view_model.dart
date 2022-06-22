import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/model/base_view_model.dart';

import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/user_location_initialize_check.dart';
import '../../dashboard/service/IDashboard_service.dart';
import '../../product_detail/model/product_detail_model.dart';

part 'categories_view_model.g.dart';

class CategoriesViewModel = _CategoriesViewModelBase with _$CategoriesViewModel;

abstract class _CategoriesViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  ScrollController? controller;

  @observable
  bool isProductFirstListLoading = false;

  @observable
  bool isProductMoreListLoading = false;

  late IDashboardService dashboardService;

  @observable
  ObservableList<ProductDetailModel> productList = ObservableList<ProductDetailModel>();

  @observable
  ObservableList<ProductDetailModel> persistProductList = ObservableList<ProductDetailModel>();

  ObservableList<String> userFavouriteList = ObservableList<String>();

  late final String shopId;

  @observable
  String filterText = "";

  @observable
  int categoryId = 0;

  @observable
  bool isSearching = false;

  @action
  void changeIsSearching() {
    isSearching = !isSearching;
    if (isSearching == false) {
      productList = persistProductList;
    }
  }

  @action
  void changeCategoryId(int value) {
    categoryId = value;
    if (categoryId != 0) {
      if (isSearching && filterText.isNotEmpty) {
        List<ProductDetailModel> _tempProductDetailList =
            persistProductList.where((element) => element.categoryId == categoryId && element.name!.toLowerCase().contains(filterText)).toList();

        productList = _tempProductDetailList.asObservable();
      } else {
        List<ProductDetailModel> _tempProductDetailList = persistProductList.where((element) => element.categoryId == categoryId).toList();

        productList = _tempProductDetailList.asObservable();
      }
    } else {
      productList = persistProductList;
    }
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
    dashboardService = DashboardService(scaffoldState, context);
  }

  @override
  void init() {
    checkUserLocation();
  }

  @action
  void changeIsProductFirstListLoading() {
    isProductFirstListLoading = !isProductFirstListLoading;
  }

  @action
  void changeIsProductMoreListLoading() {
    isProductMoreListLoading = !isProductMoreListLoading;
  }

  Future<void> checkUserLocation() async {
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
    fetchProductFirstList();
  }

  @action
  Future<void> fetchProductFirstList() async {
    changeIsProductFirstListLoading();
    String? shopId = await UserIdInitalize.instance.returnUserId(scaffoldState,context!);
    List<ProductDetailModel> _productList = shopId == null ? [] : await dashboardService.fetchDashboardProductFirstList(isCategories: true) ?? [];
    productList = _productList.asObservable();
    persistProductList = productList;

    changeIsProductFirstListLoading();
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
  void filterProducts(String productName) {
    productList = productList
        .where((item) {
          if (categoryId != 0 && isSearching) {
            return item.name!.toLowerCase().contains(productName..toLowerCase()) && item.categoryId == categoryId;
          }
          return item.name!.toLowerCase().contains(productName..toLowerCase());
        })
        .toList()
        .asObservable();
  }

  List<ProductDetailModel> filterProductList(String query) => List.of(productList).where((shop) {
        final productLower = shop.name!.toLowerCase();
        final queryLower = query.toLowerCase();

        return productLower.contains(queryLower);
      }).toList();
}
