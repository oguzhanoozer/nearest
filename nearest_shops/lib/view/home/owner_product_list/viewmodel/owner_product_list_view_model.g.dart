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

  final _$isShopProductLoadedAtom =
      Atom(name: '_OwnerProductListViewModelBase.isShopProductLoaded');

  @override
  bool get isShopProductLoaded {
    _$isShopProductLoadedAtom.reportRead();
    return super.isShopProductLoaded;
  }

  @override
  set isShopProductLoaded(bool value) {
    _$isShopProductLoadedAtom.reportWrite(value, super.isShopProductLoaded, () {
      super.isShopProductLoaded = value;
    });
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
  void changeIsShopProductLoaded() {
    final _$actionInfo =
        _$_OwnerProductListViewModelBaseActionController.startAction(
            name: '_OwnerProductListViewModelBase.changeIsShopProductLoaded');
    try {
      return super.changeIsShopProductLoaded();
    } finally {
      _$_OwnerProductListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isShopMapLoading: ${isShopMapLoading},
isShopProductLoading: ${isShopProductLoading},
isShopProductLoaded: ${isShopProductLoaded}
    ''';
  }
}
