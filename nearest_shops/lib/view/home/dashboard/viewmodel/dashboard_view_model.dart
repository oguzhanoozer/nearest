import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/base_view_model.dart';

import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../../core/init/service/firestorage/user_location_initialize_check.dart';
import '../../../product/contstants/image_path.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../../shop_list/model/shop_model.dart';
import '../model/dashboard_model.dart';
import '../service/IDashboard_service.dart';

part 'dashboard_view_model.g.dart';

class DashboardViewModel = _DashboardViewModelBase with _$DashboardViewModel;

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

  IDashboardService dashboardService = DashboardService();

  @observable
  List<ProductDetailModel> _productList = [];

  @override
  List<ProductDetailModel> _productSliderList = [];

  ObservableList<String> userFavouriteList = ObservableList<String>();

  late final String
      shopId; //// *************** ////////// shopıdServicede cağır

  @observable
  int categoryId = 0;

  @observable
  bool isFiltered = false;

  @action
  void changeCategoryId(int value) {
    categoryId = value;
    value == 0 ? isFiltered = false : isFiltered = true;
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void init() {
    /// tasks = alist.asObservable();
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

  @action
  void changeIsProductSliderListLoading() {
    isProductSliderListLoading = !isProductSliderListLoading;
  }

  Future<void> checkUserLocation() async {
    await UserLocationInitializeCheck.instance.assignUserLocation();
    initializeState();
  }

  void initializeState() async {
    controller = ScrollController()
      ..addListener(() {
        if (controller!.position.extentAfter < 300) {
          fetchProductLastList();
        }
      });
    userFavouriteList = (await UserLocationInitializeCheck.instance
        .getUserFavouriteList()
        .asObservable())!;
    fetchProductSliderList();
    fetchProductFirstList();
  }

  @action
  Future<void> fetchProductFirstList() async {
    changeIsProductFirstListLoading();
    String? shopId = await UserIdInitalize.instance.returnUserId();
    _productList = shopId == null
        ? []
        : await dashboardService.fetchDashboardProductFirstList() ?? [];

    changeIsProductFirstListLoading();
  }

  @action
  Future<void> fetchProductLastList() async {
    if (isProductFirstListLoading == false &&
        isProductMoreListLoading == false) {
      changeIsProductMoreListLoading();
      String? shopId = await UserIdInitalize.instance.returnUserId();
      List<ProductDetailModel> moreDataList = shopId == null
          ? []
          : await dashboardService.fetchDashboardProductMoreList() ?? [];
      _productList.addAll(moreDataList);
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
    String? shopId = await UserIdInitalize.instance.returnUserId();
    _productSliderList = shopId == null
        ? []
        : await dashboardService.fetchDashboardSliderList() ?? [];
    changeIsProductSliderListLoading();
  }

  List<ProductDetailModel> getProductList() {
    if (categoryId == 0) {
      return _productList;
    }
    List<ProductDetailModel> _tempProductDetailList = _productList
        .where((element) => element.categoryId == categoryId)
        .toList();
    return _tempProductDetailList;
  }

  List<ProductDetailModel> getProductSliderList() {
    return _productSliderList;
  }

  Future<void> callFirestore() async {
    // final shopsCollectionReference = _firebaseFiresore.collection("shops");
    // QuerySnapshot shopsCollectionSnapshot =
    //     await shopsCollectionReference.get();
    // List<DocumentSnapshot> docsInShops = shopsCollectionSnapshot.docs;
    // print(docsInShops.length);
    // print(docsInShops[0].get("location").latitude);
    // print(docsInShops[0].data());
    // GeoPoint geoPoint = docsInShops[0].get("location");
    // print(geoPoint.latitude);

    // ShopModel shopModel = ShopModel.fromJson(docsInShops[0].data() as Map);
    // print(shopModel.location!.latitude);

    // CollectionReference productsCollectionReference =
    //     _firebaseFiresore.collection("products");
    // QuerySnapshot productCollectionSnapshot =
    //     await productsCollectionReference.get();
    // List<DocumentSnapshot> docsInproducts = productCollectionSnapshot.docs;

    // Query query = productsCollectionReference.where("name", isEqualTo: "Kalem");
    // query.snapshots().listen((event) {
    //   DocumentSnapshot x = event.docs.first;

    //   ProductDetailModel productDetailModel =
    //       ProductDetailModel.fromJson(x.data() as Map);
    //   print("***" + productDetailModel.name.toString());
    // });

    // ProductDetailModel productDetailModel =
    //     ProductDetailModel.fromJson(docsInproducts.first.data() as Map);
    // print(DateFormat('dd/MM/yyyy').format(productDetailModel.lastSeenDate!));

    Map<String, dynamic> xx = {
      "imageUrlList": FieldValue.arrayUnion(["aaa", "bbbb", "cccs"]),
    };

    Map<String, dynamic> bb = {
      "imageUrlList": FieldValue.arrayRemove(["aaa"]),
    };

    await FirebaseCollectionRefInitialize.instance.productsCollectionReference
        .doc("1648329304018")
        .update(bb);
  }
}
