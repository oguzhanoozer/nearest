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

  final _$_ShopListViewModelBaseActionController =
      ActionController(name: '_ShopListViewModelBase');

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
  String toString() {
    return '''
isShopMapListLoading: ${isShopMapListLoading}
    ''';
  }
}
