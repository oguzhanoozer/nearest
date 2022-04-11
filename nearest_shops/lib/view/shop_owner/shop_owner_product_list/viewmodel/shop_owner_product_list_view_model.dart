import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../service/IShop_owner_product_service.dart';

part 'shop_owner_product_list_view_model.g.dart';

class ShopOwnerProductListViewModel = _ShopOwnerProductListViewModelBase
    with _$ShopOwnerProductListViewModel;

abstract class _ShopOwnerProductListViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  late ScrollController controller;

  @observable
  bool isProductFirstListLoading = false;

  @observable
  bool isProductMoreListLoading = false;

  @observable
  bool isDeleting = false;

  late IShopOwnerProductListService ownerProductListService;

  @observable
  ObservableList<ProductDetailModel> productList =
      ObservableList<ProductDetailModel>();

  @override
  void setContext(BuildContext context) {
    this.context = context;
    ownerProductListService =
        ShopOwnerProductListService(scaffoldState, context);
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
    String? shopId = await UserIdInitalize.instance.returnUserId();
    productList = (shopId == null
            ? []
            : await ownerProductListService.fetchProductFirstList(shopId) ?? [])
        as ObservableList<ProductDetailModel>;

    changeIsProductFirstListLoading();
  }

  @action
  Future<void> getProductLastList() async {
    if (isProductFirstListLoading == false &&
        isProductMoreListLoading == false) {
      changeIsProductMoreListLoading();
      String? shopId = await UserIdInitalize.instance.returnUserId();
      ObservableList<ProductDetailModel> moreDataList = (shopId == null
          ? []
          : await ownerProductListService.fetchProductMoreList(shopId) ??
              []) as ObservableList<ProductDetailModel>;
      productList.addAll(moreDataList);
      changeIsProductMoreListLoading();
    }
  }

  @action
  Future<void> deleteProduct(
      {required String productId, required int index}) async {
    changeIsDeleting();
    await ownerProductListService.deleteProductItem(productId: productId);
    productList.removeAt(index);
    showSnackBar(message: "Item was deleted");
    changeIsDeleting();
  }

  void showSnackBar({required String message}) {
    if (scaffoldState.currentState != null) {
      SnackBar(
        content: Text(message),
        duration: context!.durationNormal,
      );
    }
  }
}
