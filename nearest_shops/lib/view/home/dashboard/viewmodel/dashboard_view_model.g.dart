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

  final _$_productListAtom = Atom(name: '_DashboardViewModelBase._productList');

  @override
  List<ProductDetailModel> get _productList {
    _$_productListAtom.reportRead();
    return super._productList;
  }

  @override
  set _productList(List<ProductDetailModel> value) {
    _$_productListAtom.reportWrite(value, super._productList, () {
      super._productList = value;
    });
  }

  final _$categoryIdAtom = Atom(name: '_DashboardViewModelBase.categoryId');

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

  final _$isFilteredAtom = Atom(name: '_DashboardViewModelBase.isFiltered');

  @override
  bool get isFiltered {
    _$isFilteredAtom.reportRead();
    return super.isFiltered;
  }

  @override
  set isFiltered(bool value) {
    _$isFilteredAtom.reportWrite(value, super.isFiltered, () {
      super.isFiltered = value;
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
  void changeCategoryId(int value) {
    final _$actionInfo = _$_DashboardViewModelBaseActionController.startAction(
        name: '_DashboardViewModelBase.changeCategoryId');
    try {
      return super.changeCategoryId(value);
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
  String toString() {
    return '''
isProductFirstListLoading: ${isProductFirstListLoading},
isProductMoreListLoading: ${isProductMoreListLoading},
isProductSliderListLoading: ${isProductSliderListLoading},
categoryId: ${categoryId},
isFiltered: ${isFiltered}
    ''';
  }
}
