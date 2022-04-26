// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoriesViewModel on _CategoriesViewModelBase, Store {
  final _$isProductFirstListLoadingAtom =
      Atom(name: '_CategoriesViewModelBase.isProductFirstListLoading');

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
      Atom(name: '_CategoriesViewModelBase.isProductMoreListLoading');

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

  final _$productListAtom = Atom(name: '_CategoriesViewModelBase.productList');

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
      Atom(name: '_CategoriesViewModelBase.persistProductList');

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

  final _$filterTextAtom = Atom(name: '_CategoriesViewModelBase.filterText');

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

  final _$categoryIdAtom = Atom(name: '_CategoriesViewModelBase.categoryId');

  @override
  int get categoryId {
    _$categoryIdAtom.reportRead();
    return super.categoryId;
  }

  @override
  set categoryId(int value) {
    _$categoryIdAtom.reportWrite(value, super.categoryId, () {
      super.categoryId = value;
    });
  }

  final _$isSearchingAtom = Atom(name: '_CategoriesViewModelBase.isSearching');

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

  final _$fetchProductFirstListAsyncAction =
      AsyncAction('_CategoriesViewModelBase.fetchProductFirstList');

  @override
  Future<void> fetchProductFirstList() {
    return _$fetchProductFirstListAsyncAction
        .run(() => super.fetchProductFirstList());
  }

  final _$fetchProductLastListAsyncAction =
      AsyncAction('_CategoriesViewModelBase.fetchProductLastList');

  @override
  Future<void> fetchProductLastList() {
    return _$fetchProductLastListAsyncAction
        .run(() => super.fetchProductLastList());
  }

  final _$changeFavouriteListAsyncAction =
      AsyncAction('_CategoriesViewModelBase.changeFavouriteList');

  @override
  Future<void> changeFavouriteList(String productId) {
    return _$changeFavouriteListAsyncAction
        .run(() => super.changeFavouriteList(productId));
  }

  final _$_CategoriesViewModelBaseActionController =
      ActionController(name: '_CategoriesViewModelBase');

  @override
  void changeIsSearching() {
    final _$actionInfo = _$_CategoriesViewModelBaseActionController.startAction(
        name: '_CategoriesViewModelBase.changeIsSearching');
    try {
      return super.changeIsSearching();
    } finally {
      _$_CategoriesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCategoryId(int value) {
    final _$actionInfo = _$_CategoriesViewModelBaseActionController.startAction(
        name: '_CategoriesViewModelBase.changeCategoryId');
    try {
      return super.changeCategoryId(value);
    } finally {
      _$_CategoriesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsProductFirstListLoading() {
    final _$actionInfo = _$_CategoriesViewModelBaseActionController.startAction(
        name: '_CategoriesViewModelBase.changeIsProductFirstListLoading');
    try {
      return super.changeIsProductFirstListLoading();
    } finally {
      _$_CategoriesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsProductMoreListLoading() {
    final _$actionInfo = _$_CategoriesViewModelBaseActionController.startAction(
        name: '_CategoriesViewModelBase.changeIsProductMoreListLoading');
    try {
      return super.changeIsProductMoreListLoading();
    } finally {
      _$_CategoriesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterProducts(String productName) {
    final _$actionInfo = _$_CategoriesViewModelBaseActionController.startAction(
        name: '_CategoriesViewModelBase.filterProducts');
    try {
      return super.filterProducts(productName);
    } finally {
      _$_CategoriesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isProductFirstListLoading: ${isProductFirstListLoading},
isProductMoreListLoading: ${isProductMoreListLoading},
productList: ${productList},
persistProductList: ${persistProductList},
filterText: ${filterText},
categoryId: ${categoryId},
isSearching: ${isSearching}
    ''';
  }
}
