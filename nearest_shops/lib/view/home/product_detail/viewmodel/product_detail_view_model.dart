import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';
import 'package:nearest_shops/core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/base/model/home_dashboard_navigation_arg.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../utility/error_helper.dart';
import '../../shop_list/model/shop_model.dart';

import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../dashboard/view/home_dashboard_navigation_view.dart';

part 'product_detail_view_model.g.dart';

class ProductDetailViewModel = _ProductDetailViewModelBase with _$ProductDetailViewModel;

abstract class _ProductDetailViewModelBase with Store, BaseViewModel, ErrorHelper {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void init() {}

  @observable
  int selectedCurrentIndex = 0;

  @action
  void onChanged(int index) {
    selectedCurrentIndex = index;
  }

  @observable
  bool? isCurrentFavurite; 

  bool? isPopFalse = false;

  @action
  void changeCurrentFavourite() {
    if (isCurrentFavurite != null) {
      isCurrentFavurite = !isCurrentFavurite!;
    }
  }

  @action
  void setCurrentFavourite(bool favValue) {
    isCurrentFavurite = favValue;
    isPopFalse = true;
  }

  @override
  Future<ShopModel?> fetchShopData(String shopId) async {
    try {
      final shopQuery = await FirebaseCollectionRefInitialize.instance.shopsCollectionReference.where(ContentString.ID.rawValue, isEqualTo: shopId).get();

      if (shopQuery.docs.isNotEmpty) {
        ShopModel shop = ShopModel.fromJson(shopQuery.docs.toList().first.data() as Map);
        return shop;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(scaffoldState, context!, LocaleKeys.loginError.locale);
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context!, LocaleKeys.loginError.locale);
    } catch (e) {
      showSnackBar(scaffoldState, context!, LocaleKeys.loginError.locale);
    }
  }

  Future<void> pushToShopsMap(BuildContext context, String shopId) async {
    ShopModel? currentShopModel = await fetchShopData(shopId);
    if (currentShopModel != null) {
      Navigator.pushReplacementNamed(context, homeNavigationDashboardViewRoute,
          arguments: HomeDashboardNavigationArg(
            currentShopModel,
            isDirection: true,
          ));
    }
  }
}
