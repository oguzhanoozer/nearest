// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_owner_product_list_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShopOwnerProductListViewModel
    on _ShopOwnerProductListViewModelBase, Store {
  final _$isProductFirstListLoadingAtom = Atom(
      name: '_ShopOwnerProductListViewModelBase.isProductFirstListLoading');

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
      Atom(name: '_ShopOwnerProductListViewModelBase.isProductMoreListLoading');

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

  final _$isDeletingAtom =
      Atom(name: '_ShopOwnerProductListViewModelBase.isDeleting');

  @override
  bool get isDeleting {
    _$isDeletingAtom.reportRead();
    return super.isDeleting;
  }

  @override
  set isDeleting(bool value) {
    _$isDeletingAtom.reportWrite(value, super.isDeleting, () {
      super.isDeleting = value;
    });
  }

  final _$productListAtom =
      Atom(name: '_ShopOwnerProductListViewModelBase.productList');

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

  final _$getProductFirstListAsyncAction =
      AsyncAction('_ShopOwnerProductListViewModelBase.getProductFirstList');

  @override
  Future<void> getProductFirstList() {
    return _$getProductFirstListAsyncAction
        .run(() => super.getProductFirstList());
  }

  final _$getProductLastListAsyncAction =
      AsyncAction('_ShopOwnerProductListViewModelBase.getProductLastList');

  @override
  Future<void> getProductLastList() {
    return _$getProductLastListAsyncAction
        .run(() => super.getProductLastList());
  }

  final _$deleteProductAsyncAction =
      AsyncAction('_ShopOwnerProductListViewModelBase.deleteProduct');

  @override
  Future<void> deleteProduct({required String productId, required int index}) {
    return _$deleteProductAsyncAction
        .run(() => super.deleteProduct(productId: productId, index: index));
  }

  final _$_ShopOwnerProductListViewModelBaseActionController =
      ActionController(name: '_ShopOwnerProductListViewModelBase');

  @override
  void changeIsProductFirstListLoading() {
    final _$actionInfo =
        _$_ShopOwnerProductListViewModelBaseActionController.startAction(
            name:
                '_ShopOwnerProductListViewModelBase.changeIsProductFirstListLoading');
    try {
      return super.changeIsProductFirstListLoading();
    } finally {
      _$_ShopOwnerProductListViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeIsProductMoreListLoading() {
    final _$actionInfo =
        _$_ShopOwnerProductListViewModelBaseActionController.startAction(
            name:
                '_ShopOwnerProductListViewModelBase.changeIsProductMoreListLoading');
    try {
      return super.changeIsProductMoreListLoading();
    } finally {
      _$_ShopOwnerProductListViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeIsDeleting() {
    final _$actionInfo =
        _$_ShopOwnerProductListViewModelBaseActionController.startAction(
            name: '_ShopOwnerProductListViewModelBase.changeIsDeleting');
    try {
      return super.changeIsDeleting();
    } finally {
      _$_ShopOwnerProductListViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isProductFirstListLoading: ${isProductFirstListLoading},
isProductMoreListLoading: ${isProductMoreListLoading},
isDeleting: ${isDeleting},
productList: ${productList}
    ''';
  }
}
