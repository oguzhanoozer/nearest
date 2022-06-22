import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../utility/error_helper.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../model/product_comment_model.dart';

part 'product_comment_view_model.g.dart';

class ProductCommentViewModel = _ProductCommentViewModelBase with _$ProductCommentViewModel;

abstract class _ProductCommentViewModelBase with Store, BaseViewModel, ErrorHelper {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @observable
  String currentCommentText = "";

  @override
  void init({String? productId}) {
    fetchComment(productId!);
  }

  @override
  setContext(BuildContext context) {
    this.context = context;
  }

  @observable
  ObservableList<ProductCommentModel> productCommentList = ObservableList<ProductCommentModel>();

  @action
  Future<void> addComment(String commentText, String productId) async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();

      ProductCommentModel productCommentModel =
          ProductCommentModel(comment: commentText, userId: user!.uid, userName: user.displayName ?? ContentString.USER.rawValue, userPhotoUrl: user.photoURL);

      Map<String, dynamic> addItemMap = {
        "comments": FieldValue.arrayUnion([productCommentModel.toMap()]),
      };

      await FirebaseCollectionRefInitialize.instance.productsCollectionReference.doc(productId).update(addItemMap);
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context!, LocaleKeys.loginError.locale);
    }
  }

  @action
  Future<ObservableList<ProductCommentModel>?> fetchComment(String productId) async {
    try {
      DocumentReference reference = FirebaseCollectionRefInitialize.instance.productsCollectionReference.doc(productId);
      reference.snapshots().listen((querySnapshot) {
        if (querySnapshot.data() != null) {
          final productModel = ProductDetailModel.fromJson(querySnapshot.data() as Map);
          productCommentList = (productModel.comments ?? []).reversed.toList().asObservable();
        }
      });
      return productCommentList;
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context!, LocaleKeys.loginError.locale);
    }
  }
}
