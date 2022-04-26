// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DashboardViewModel on _DashboardViewModelBase, Store {
  final _$isProductFirstListLoadingAtom =
      Atom(name: '_DashboardViewModelBase.isProductFirstListLoading');

  @override
  bool get isProductFirstListLoading {
    _$isProductFirstListLoadingAtom.reportRead();
    return super.isProductFirstListLoading;
  }

  @override
  set isProductFirstListLoading(bool value) {
    _$isProductFirstListLoadingAtom
        .reportWrite(value, super.isProductFirstListLoading, () {
      super.isProductFirstListLoading = value;
    });
  }

  final _$isProductMoreListLoadingAtom =
      Atom(name: '_DashboardViewModelBase.isProductMoreListLoading');

  @override
  bool get isProductMoreListLoading {
    _$isProductMoreListLoadingAtom.reportRead();
    return super.isProductMoreListLoading;
  }

  @override
  set isProductMoreListLoading(bool value) {
    _$isProductMoreListLoadingAtom
        .reportWrite(value, super.isProductMoreListLoading, () {
      super.isProductMoreListLoading = value;
    });
  }

  final _$isProductSliderListLoadingAtom =
      Atom(name: '_DashboardViewModelBase.isProductSliderListLoading');

  @override
  bool get isProductSliderListLoading {
    _$isProductSliderListLoadingAtom.reportRead();
    return super.isProductSliderListLoading;
  }

  @override
  set isProductSliderListLoading(bool value) {
    _$isProductSliderListLoadingAtom
        .reportWrite(value, super.isProductSliderListLoading, () {
      super.isProductSliderListLoading = value;
    });
  }

  final _$isSearchingAtom = Atom(name: '_DashboardViewModelBase.isSearching');

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

  final _$productListAtom = Atom(name: '_DashboardViewModelBase.productList');

  @override
  ObservableList<ProductDetailModel> get productList {
    _$productListAtom.reportRead();
    return super.productList;
  }

  @override
  set productList(ObservableList<ProductDetailModel> value) {
    _$productListAtom.reportWrite(value, super.productList, () {
      super.productList = value;
    });
  }

  final _$persistProductListAtom =
      Atom(name: '_DashboardViewModelBase.persistProductList');

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

  final _$filterTextAtom = Atom(name: '_DashboardViewModelBase.filterText');

  @override
  String get filterText {
    _$filterTextAtom.reportRead();
    return super.filterText;
  }

  @override
  set filterText(String value) {
    _$filterTextAtom.reportWrite(value, super.filterText, () {
      super.filterText = value;
    });
  }

  final _$fetchProductFirstListAsyncAction =
      AsyncAction('_DashboardViewModelBase.fetchProductFirstList');

  @override
  Future<void> fetchProductFirstList() {
    return _$fetchProductFirstListAsyncAction
        .run(() => super.fetchProductFirstList());
  }

  final _$fetchProductLastListAsyncAction =
      AsyncAction('_DashboardViewModelBase.fetchProductLastList');

  @override
  Future<void> fetchProductLastList() {
    return _$fetchProductLastListAsyncAction
        .run(() => super.fetchProductLastList());
  }

  final _$changeFavouriteListAsyncAction =
      AsyncAction('_DashboardViewModelBase.changeFavouriteList');

  @override
  Future<void> changeFavouriteList(String productId) {
    return _$changeFavouriteListAsyncAction
        .run(() => super.changeFavouriteList(productId));
  }

  final _$fetchProductSliderListAsyncAction =
      AsyncAction('_DashboardViewModelBase.fetchProductSliderList');

  @override
  Future<void> fetchProductSliderList() {
    return _$fetchProductSliderListAsyncAction
        .run(() => super.fetchProductSliderList());
  }

  final _$_DashboardViewModelBaseActionController =
      ActionController(name: '_DashboardViewModelBase');

  @override
  void changeIsSearching(bool value) {
    final _$actionInfo = _$_DashboardViewModelBaseActionController.startAction(
        name: '_DashboardViewModelBase.changeIsSearching');
    try {
      return super.changeIsSearching(value);
    } finally {
      _$_DashboardViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsProductFirstListLoading() {
    final _$actionInfo = _$_DashboardViewModelBaseActionController.startAction(
        name: '_DashboardViewModelBase.changeIsProductFirstListLoading');
    try {
      return super.changeIsProductFirstListLoading();
    } finally {
      _$_DashboardViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsProductMoreListLoading() {
    final _$actionInfo = _$_DashboardViewModelBaseActionController.startAction(
        name: '_DashboardViewModelBase.changeIsProductMoreListLoading');
    try {
      return super.changeIsProductMoreListLoading();
    } finally {
      _$_DashboardViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsProductSliderListLoading() {
    final _$actionInfo = _$_DashboardViewModelBaseActionController.startAction(
        name: '_DashboardViewModelBase.changeIsProductSliderListLoading');
    try {
      return super.changeIsProductSliderListLoading();
    } finally {
      _$_DashboardViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterProducts(String productName) {
    final _$actionInfo = _$_DashboardViewModelBaseActionController.startAction(
        name: '_DashboardViewModelBase.filterProducts');
    try {
      return super.filterProducts(productName);
    } finally {
      _$_DashboardViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isProductFirstListLoading: ${isProductFirstListLoading},
isProductMoreListLoading: ${isProductMoreListLoading},
isProductSliderListLoading: ${isProductSliderListLoading},
isSearching: ${isSearching},
productList: ${productList},
persistProductList: ${persistProductList},
filterText: ${filterText}
    ''';
  }
}
