import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../product_detail/model/product_detail_model.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../service/user_favourite_list_service.dart';
part 'user_favourite_list_view_model.g.dart';

class UserFavouriteListViewModel = _UserFavouriteListViewModelBase
    with _$UserFavouriteListViewModel;

abstract class _UserFavouriteListViewModelBase with Store, BaseViewModel {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  late IUserFavouriteListService userFavouriteListService;

  @observable
  bool isProductListLoading = false;

  @observable
  bool isSearching = false;

  @action
  void changeIsSearching() {
    isSearching = !isSearching;
    if (isSearching == false) {
      favouriteProductList = persistProductList;
    }
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
    userFavouriteListService = UserFavouriteListService(scaffoldState, context);
  }

  @action
  void changeIsProductListLoading() {
    isProductListLoading = !isProductListLoading;
  }

  @override
  void init() {
    fetchFavouriteProductList();
  }

  @observable
  ObservableList<ProductDetailModel> favouriteProductList =
      ObservableList<ProductDetailModel>();
  @observable
  ObservableList<ProductDetailModel> persistProductList =
      ObservableList<ProductDetailModel>();

  @action
  Future<void> fetchFavouriteProductList() async {
    changeIsProductListLoading();
    final favouriteDataList =
        await userFavouriteListService.fetchFavouriteProductList();
    if (favouriteDataList != null) {
      favouriteProductList = favouriteDataList.asObservable();
      persistProductList = favouriteDataList.asObservable();
    }

    changeIsProductListLoading();
  }

  @action
  Future<void> removeFavouriteItem(int index) async {
    await userFavouriteListService.removeItemToFavouriteList(
        favouriteProductList[index].productId.toString());
    favouriteProductList.removeAt(index);
    persistProductList.removeAt(index);
  }

  @action
  void filterProducts(String productName) {
    favouriteProductList = favouriteProductList
        .where((item) =>
            item.name!.toLowerCase().contains(productName..toLowerCase()))
        .toList()
        .asObservable();
  }
}
