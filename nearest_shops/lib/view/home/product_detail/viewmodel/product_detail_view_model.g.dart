// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductDetailViewModel on _ProductDetailViewModelBase, Store {
  final _$selectedCurrentIndexAtom =
      Atom(name: '_ProductDetailViewModelBase.selectedCurrentIndex');

  @override
  int get selectedCurrentIndex {
    _$selectedCurrentIndexAtom.reportRead();
    return super.selectedCurrentIndex;
  }

  @override
  set selectedCurrentIndex(int value) {
    _$selectedCurrentIndexAtom.reportWrite(value, super.selectedCurrentIndex,
        () {
      super.selectedCurrentIndex = value;
    });
  }

  final _$isCurrentFavuriteAtom =
      Atom(name: '_ProductDetailViewModelBase.isCurrentFavurite');

  @override
  bool? get isCurrentFavurite {
    _$isCurrentFavuriteAtom.reportRead();
    return super.isCurrentFavurite;
  }

  @override
  set isCurrentFavurite(bool? value) {
    _$isCurrentFavuriteAtom.reportWrite(value, super.isCurrentFavurite, () {
      super.isCurrentFavurite = value;
    });
  }

  final _$_ProductDetailViewModelBaseActionController =
      ActionController(name: '_ProductDetailViewModelBase');

  @override
  void onChanged(int index) {
    final _$actionInfo = _$_ProductDetailViewModelBaseActionController
        .startAction(name: '_ProductDetailViewModelBase.onChanged');
    try {
      return super.onChanged(index);
    } finally {
      _$_ProductDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCurrentFavourite() {
    final _$actionInfo =
        _$_ProductDetailViewModelBaseActionController.startAction(
            name: '_ProductDetailViewModelBase.changeCurrentFavourite');
    try {
      return super.changeCurrentFavourite();
    } finally {
      _$_ProductDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentFavourite(bool favValue) {
    final _$actionInfo = _$_ProductDetailViewModelBaseActionController
        .startAction(name: '_ProductDetailViewModelBase.setCurrentFavourite');
    try {
      return super.setCurrentFavourite(favValue);
    } finally {
      _$_ProductDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCurrentIndex: ${selectedCurrentIndex},
isCurrentFavurite: ${isCurrentFavurite}
    ''';
  }
}
