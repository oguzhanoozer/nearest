// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_product_list_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OwnerProductListViewModel on _OwnerProductListViewModelBase, Store {
  final _$isShopMapLoadingAtom =
      Atom(name: '_OwnerProductListViewModelBase.isShopMapLoading');

  @override
  bool get isShopMapLoading {
    _$isShopMapLoadingAtom.reportRead();
    return super.isShopMapLoading;
  }

  @override
  set isShopMapLoading(bool value) {
    _$isShopMapLoadingAtom.reportWrite(value, super.isShopMapLoading, () {
      super.isShopMapLoading = value;
    });
  }

  final _$isShopProductLoadingAtom =
      Atom(name: '_OwnerProductListViewModelBase.isShopProductLoading');

  @override
  bool get isShopProductLoading {
    _$isShopProductLoadingAtom.reportRead();
    return super.isShopProductLoading;
  }

  @override
  set isShopProductLoading(bool value) {
    _$isShopProductLoadingAtom.reportWrite(value, super.isShopProductLoading,
        () {
      super.isShopProductLoading = value;
    });
  }

  final _$isShopProductDraggleLoadedAtom =
      Atom(name: '_OwnerProductListViewModelBase.isShopProductDraggleLoaded');

  @override
  bool get isShopProductDraggleLoaded {
    _$isShopProductDraggleLoadedAtom.reportRead();
    return super.isShopProductDraggleLoaded;
  }

  @override
  set isShopProductDraggleLoaded(bool value) {
    _$isShopProductDraggleLoadedAtom
        .reportWrite(value, super.isShopProductDraggleLoaded, () {
      super.isShopProductDraggleLoaded = value;
    });
  }

  final _$fetchShopProductsAsyncAction =
      AsyncAction('_OwnerProductListViewModelBase.fetchShopProducts');

  @override
  Future<void> fetchShopProducts({required String shopId}) {
    return _$fetchShopProductsAsyncAction
        .run(() => super.fetchShopProducts(shopId: shopId));
  }

  final _$_OwnerProductListViewModelBaseActionController =
      ActionController(name: '_OwnerProductListViewModelBase');

  @override
  void changeIsShopMapLoading() {
    final _$actionInfo =
        _$_OwnerProductListViewModelBaseActionController.startAction(
            name: '_OwnerProductListViewModelBase.changeIsShopMapLoading');
    try {
      return super.changeIsShopMapLoading();
    } finally {
      _$_OwnerProductListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsShopProductLoading() {
    final _$actionInfo =
        _$_OwnerProductListViewModelBaseActionController.startAction(
            name: '_OwnerProductListViewModelBase.changeIsShopProductLoading');
    try {
      return super.changeIsShopProductLoading();
    } finally {
      _$_OwnerProductListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsShopProductLoaded(bool value) {
    final _$actionInfo =
        _$_OwnerProductListViewModelBaseActionController.startAction(
            name: '_OwnerProductListViewModelBase.changeIsShopProductLoaded');
    try {
      return super.changeIsShopProductLoaded(value);
    } finally {
      _$_OwnerProductListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setContext(BuildContext context) {
    final _$actionInfo = _$_OwnerProductListViewModelBaseActionController
        .startAction(name: '_OwnerProductListViewModelBase.setContext');
    try {
      return super.setContext(context);
    } finally {
      _$_OwnerProductListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMarker(ShopModel shopModel) {
    final _$actionInfo = _$_OwnerProductListViewModelBaseActionController
        .startAction(name: '_OwnerProductListViewModelBase.addMarker');
    try {
      return super.addMarker(shopModel);
    } finally {
      _$_OwnerProductListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isShopMapLoading: ${isShopMapLoading},
isShopProductLoading: ${isShopProductLoading},
isShopProductDraggleLoaded: ${isShopProductDraggleLoaded}
    ''';
  }
}
