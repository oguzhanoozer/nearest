// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_comment_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductCommentViewModel on _ProductCommentViewModelBase, Store {
  final _$currentCommentTextAtom =
      Atom(name: '_ProductCommentViewModelBase.currentCommentText');

  @override
  String get currentCommentText {
    _$currentCommentTextAtom.reportRead();
    return super.currentCommentText;
  }

  @override
  set currentCommentText(String value) {
    _$currentCommentTextAtom.reportWrite(value, super.currentCommentText, () {
      super.currentCommentText = value;
    });
  }

  final _$productCommentListAtom =
      Atom(name: '_ProductCommentViewModelBase.productCommentList');

  @override
  ObservableList<ProductCommentModel> get productCommentList {
    _$productCommentListAtom.reportRead();
    return super.productCommentList;
  }

  @override
  set productCommentList(ObservableList<ProductCommentModel> value) {
    _$productCommentListAtom.reportWrite(value, super.productCommentList, () {
      super.productCommentList = value;
    });
  }

  final _$addCommentAsyncAction =
      AsyncAction('_ProductCommentViewModelBase.addComment');

  @override
  Future<void> addComment(String commentText, String productId) {
    return _$addCommentAsyncAction
        .run(() => super.addComment(commentText, productId));
  }

  final _$fetchCommentAsyncAction =
      AsyncAction('_ProductCommentViewModelBase.fetchComment');

  @override
  Future<ObservableList<ProductCommentModel>?> fetchComment(String productId) {
    return _$fetchCommentAsyncAction.run(() => super.fetchComment(productId));
  }

  @override
  String toString() {
    return '''
currentCommentText: ${currentCommentText},
productCommentList: ${productCommentList}
    ''';
  }
}
