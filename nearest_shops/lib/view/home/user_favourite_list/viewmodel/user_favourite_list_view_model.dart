import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../service/user_favourite_list_service.dart';
part 'user_favourite_list_view_model.g.dart';

class UserFavouriteListViewModel = _UserFavouriteListViewModelBase
    with _$UserFavouriteListViewModel;

abstract class _UserFavouriteListViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  IUserFavouriteListService userFavouriteListService =
      UserFavouriteListService();

  @observable
  bool isProductListLoading = false;

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @action
  void changeIsProductListLoading() {
    isProductListLoading = !isProductListLoading;
  }

  @override
  void init() {
    fetchFavouriteProductList();
  }

  ObservableList<ProductDetailModel> favouriteProductList =
      ObservableList<ProductDetailModel>();

  Future<void> fetchFavouriteProductList() async {
    changeIsProductListLoading();
    final favouriteDataList =
        await userFavouriteListService.fetchFavouriteProductList();
    favouriteProductList = favouriteDataList.asObservable();
    changeIsProductListLoading();
  }

  Future<void> removeFavouriteItem(int index) async {
    await userFavouriteListService.removeItemToFavouriteList(
        favouriteProductList[index].productId.toString());
    favouriteProductList.removeAt(index);
  }
}
