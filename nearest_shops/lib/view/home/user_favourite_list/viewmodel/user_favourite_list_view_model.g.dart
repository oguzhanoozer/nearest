// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_favourite_list_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserFavouriteListViewModel on _UserFavouriteListViewModelBase, Store {
  final _$isProductListLoadingAtom =
      Atom(name: '_UserFavouriteListViewModelBase.isProductListLoading');

  @override
  bool get isProductListLoading {
    _$isProductListLoadingAtom.reportRead();
    return super.isProductListLoading;
  }

  @override
  set isProductListLoading(bool value) {
    _$isProductListLoadingAtom.reportWrite(value, super.isProductListLoading,
        () {
      super.isProductListLoading = value;
    });
  }

  final _$isSearchingAtom =
      Atom(name: '_UserFavouriteListViewModelBase.isSearching');

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  final _$favouriteProductListAtom =
      Atom(name: '_UserFavouriteListViewModelBase.favouriteProductList');

  @override
  ObservableList<ProductDetailModel> get favouriteProductList {
    _$favouriteProductListAtom.reportRead();
    return super.favouriteProductList;
  }

  @override
  set favouriteProductList(ObservableList<ProductDetailModel> value) {
    _$favouriteProductListAtom.reportWrite(value, super.favouriteProductList,
        () {
      super.favouriteProductList = value;
    });
  }

  final _$persistProductListAtom =
      Atom(name: '_UserFavouriteListViewModelBase.persistProductList');

  @override
  ObservableList<ProductDetailModel> get persistProductList {
    _$persistProductListAtom.reportRead();
    return super.persistProductList;
  }

  @override
  set persistProductList(ObservableList<ProductDetailModel> value) {
    _$persistProductListAtom.reportWrite(value, super.persistProductList, () {
      super.persistProductList = value;
    });
  }

  final _$fetchFavouriteProductListAsyncAction =
      AsyncAction('_UserFavouriteListViewModelBase.fetchFavouriteProductList');

  @override
  Future<void> fetchFavouriteProductList() {
    return _$fetchFavouriteProductListAsyncAction
        .run(() => super.fetchFavouriteProductList());
  }

  final _$removeFavouriteItemAsyncAction =
      AsyncAction('_UserFavouriteListViewModelBase.removeFavouriteItem');

  @override
  Future<void> removeFavouriteItem(int index) {
    return _$removeFavouriteItemAsyncAction
        .run(() => super.removeFavouriteItem(index));
  }

  final _$removeFromFavouriteListAsyncAction =
      AsyncAction('_UserFavouriteListViewModelBase.removeFromFavouriteList');

  @override
  Future<void> removeFromFavouriteList(ProductDetailModel productDetailModel) {
    return _$removeFromFavouriteListAsyncAction
        .run(() => super.removeFromFavouriteList(productDetailModel));
  }

  final _$_UserFavouriteListViewModelBaseActionController =
      ActionController(name: '_UserFavouriteListViewModelBase');

  @override
  void changeIsSearching() {
    final _$actionInfo = _$_UserFavouriteListViewModelBaseActionController
        .startAction(name: '_UserFavouriteListViewModelBase.changeIsSearching');
    try {
      return super.changeIsSearching();
    } finally {
      _$_UserFavouriteListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsProductListLoading() {
    final _$actionInfo =
        _$_UserFavouriteListViewModelBaseActionController.startAction(
            name: '_UserFavouriteListViewModelBase.changeIsProductListLoading');
    try {
      return super.changeIsProductListLoading();
    } finally {
      _$_UserFavouriteListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterProducts(String productName) {
    final _$actionInfo = _$_UserFavouriteListViewModelBaseActionController
        .startAction(name: '_UserFavouriteListViewModelBase.filterProducts');
    try {
      return super.filterProducts(productName);
    } finally {
      _$_UserFavouriteListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isProductListLoading: ${isProductListLoading},
isSearching: ${isSearching},
favouriteProductList: ${favouriteProductList},
persistProductList: ${persistProductList}
    ''';
  }
}
