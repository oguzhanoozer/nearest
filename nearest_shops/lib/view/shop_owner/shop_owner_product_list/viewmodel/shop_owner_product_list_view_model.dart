import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/view/product/input_text_decoration.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../service/IShop_owner_product_service.dart';

part 'shop_owner_product_list_view_model.g.dart';

class ShopOwnerProductListViewModel = _ShopOwnerProductListViewModelBase with _$ShopOwnerProductListViewModel;

abstract class _ShopOwnerProductListViewModelBase with Store, BaseViewModel, ErrorHelper {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  late ScrollController controller;

  @observable
  bool isProductFirstListLoading = false;

  @observable
  bool isProductMoreListLoading = false;

  @observable
  bool isDeleting = false;

  @observable
  bool isSearching = false;

  late IShopOwnerProductListService ownerProductListService;

  @observable
  ObservableList<ProductDetailModel> persistProductList = ObservableList<ProductDetailModel>();

  @observable
  ObservableList<ProductDetailModel> productList = ObservableList<ProductDetailModel>();

  @action
  void changeIsSearching() {
    isSearching = !isSearching;
    if (isSearching == false) {
      productList = persistProductList;
    }
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
    ownerProductListService = ShopOwnerProductListService(scaffoldState, context);
  }

  @override
  void init() {
    controller = ScrollController()
      ..addListener(() {
        if (controller.position.extentAfter < 300) {
          getProductLastList();
        }
      });
    getProductFirstList();
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
  void changeIsDeleting() {
    isDeleting = !isDeleting;
  }

  @action
  Future<void> getProductFirstList() async {
    changeIsProductFirstListLoading();
    String? shopId = await UserIdInitalize.instance.returnUserId(scaffoldState, context!);
    productList = (shopId == null ? [] : await ownerProductListService.fetchProductFirstList(shopId) ?? []) as ObservableList<ProductDetailModel>;

    persistProductList = productList;

    changeIsProductFirstListLoading();
  }

  @action
  Future<void> getProductLastList() async {
    if (isProductFirstListLoading == false && isProductMoreListLoading == false) {
      changeIsProductMoreListLoading();
      String? shopId = await UserIdInitalize.instance.returnUserId(scaffoldState, context!);
      ObservableList<ProductDetailModel> moreDataList =
          (shopId == null ? [] : await ownerProductListService.fetchProductMoreList(shopId) ?? []) as ObservableList<ProductDetailModel>;
      productList.addAll(moreDataList);
      persistProductList = productList;
      changeIsProductMoreListLoading();
    }
  }

  @action
  Future<void> deleteProduct({required String productId, required int index}) async {
    changeIsDeleting();
    await ownerProductListService.deleteProductItem(productId: productId);
    productList.removeAt(index);
    showSnackBar(scaffoldState, context!, LocaleKeys.itemWasDeletedText.locale);
    persistProductList = productList;
    changeIsDeleting();
  }

  @action
  void changeProductList(int index, ProductDetailModel productDetailModel) {
    productList[index] = productDetailModel;
    persistProductList[index] = productDetailModel;
  }

  @action
  void filterProducts(String productName) {
    productList = productList.where((item) => item.name!.toLowerCase().contains(productName..toLowerCase())).toList().asObservable();
  }
}
