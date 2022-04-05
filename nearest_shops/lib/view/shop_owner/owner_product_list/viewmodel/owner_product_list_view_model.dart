import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/base_view_model.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';
import 'package:nearest_shops/view/shop_owner/owner_product_list/service/IOwner_product_service.dart';

import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
part 'owner_product_list_view_model.g.dart';

class OwnerProductListViewModel = _OwnerProductListViewModelBase
    with _$OwnerProductListViewModel;

abstract class _OwnerProductListViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  late ScrollController controller;

  @observable
  bool isProductFirstListLoading = false;

  @observable
  bool isProductMoreListLoading = false;

  @observable
  bool isDeleting = false;

  IOwnerProductListService ownerProductListService = OwnerProductListService();

  @observable
  ObservableList<ProductDetailModel> productList =
      ObservableList<ProductDetailModel>();

  late final String shopId; //// *************** //////////

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void init() {
    controller = ScrollController()
      ..addListener(() {
        // double maxScroll = controller.position.maxScrollExtent;
        //double currentScroll = controller.position.pixels;
        // double delta = MediaQuery.of(context!).size.height * 0.20;
        // if (maxScroll - currentScroll <= delta) {
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
      scaffoldState.currentState!
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
