// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_list_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShopListViewModel on _ShopListViewModelBase, Store {
  final _$isShopMapListLoadingAtom =
      Atom(name: '_ShopListViewModelBase.isShopMapListLoading');

  @override
  bool get isShopMapListLoading {
    _$isShopMapListLoadingAtom.reportRead();
    return super.isShopMapListLoading;
  }

  @override
  set isShopMapListLoading(bool value) {
    _$isShopMapListLoadingAtom.reportWrite(value, super.isShopMapListLoading,
        () {
      super.isShopMapListLoading = value;
    });
  }

  final _$isSearchingAtom = Atom(name: '_ShopListViewModelBase.isSearching');

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

  final _$shopModelListAtom =
      Atom(name: '_ShopListViewModelBase.shopModelList');

  @override
  ObservableList<ShopModel> get shopModelList {
    _$shopModelListAtom.reportRead();
    return super.shopModelList;
  }

  @override
  set shopModelList(ObservableList<ShopModel> value) {
    _$shopModelListAtom.reportWrite(value, super.shopModelList, () {
      super.shopModelList = value;
    });
  }

  final _$_shopPersistModelListAtom =
      Atom(name: '_ShopListViewModelBase._shopPersistModelList');

  @override
  ObservableList<ShopModel> get _shopPersistModelList {
    _$_shopPersistModelListAtom.reportRead();
    return super._shopPersistModelList;
  }

  @override
  set _shopPersistModelList(ObservableList<ShopModel> value) {
    _$_shopPersistModelListAtom.reportWrite(value, super._shopPersistModelList,
        () {
      super._shopPersistModelList = value;
    });
  }

  final _$_ShopListViewModelBaseActionController =
      ActionController(name: '_ShopListViewModelBase');

  @override
  void changeIsSearching() {
    final _$actionInfo = _$_ShopListViewModelBaseActionController.startAction(
        name: '_ShopListViewModelBase.changeIsSearching');
    try {
      return super.changeIsSearching();
    } finally {
      _$_ShopListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsShopMapListLoading() {
    final _$actionInfo = _$_ShopListViewModelBaseActionController.startAction(
        name: '_ShopListViewModelBase.changeIsShopMapListLoading');
    try {
      return super.changeIsShopMapListLoading();
    } finally {
      _$_ShopListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterProducts(String productName) {
    final _$actionInfo = _$_ShopListViewModelBaseActionController.startAction(
        name: '_ShopListViewModelBase.filterProducts');
    try {
      return super.filterProducts(productName);
    } finally {
      _$_ShopListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isShopMapListLoading: ${isShopMapListLoading},
isSearching: ${isSearching},
shopModelList: ${shopModelList}
    ''';
  }
}
