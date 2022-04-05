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

  final _$_UserFavouriteListViewModelBaseActionController =
      ActionController(name: '_UserFavouriteListViewModelBase');

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
  String toString() {
    return '''
isProductListLoading: ${isProductListLoading}
    ''';
  }
}
