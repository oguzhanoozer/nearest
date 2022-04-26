import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../home/shop_list/model/shop_model.dart';
import '../../../utility/error_helper.dart';

import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';

abstract class IShopOwnerProfileService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IShopOwnerProfileService(this.scaffoldState, this.context);

  Future<String?> uploadProfileImage(File pickedFile);
  Future<void> updateShopData(ShopModel shopModel, ShopModel tempShopModel);
  Future<ShopModel?> fetchShopData();
  Future<String?> _uploadFile(File _image, User user);
  Future<void> deleteAccount();
}

class ShopOwnerProfileService extends IShopOwnerProfileService
    with ErrorHelper {
  ShopOwnerProfileService(
      GlobalKey<ScaffoldState> scaffoldState, BuildContext context)
      : super(scaffoldState, context);

  @override
  Future<String?> uploadProfileImage(File pickedFile) async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();
      if (user != null) {
        String? profileImageUrl =
            await _uploadFile(File(pickedFile.path), user);
        if (profileImageUrl != null) {
          await user.updatePhotoURL(profileImageUrl);
          return profileImageUrl;
        }
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.errorOnUploadingProfileImagaText.locale);
      return null;
    }
  }

  @override
  Future<void> updateShopData(
      ShopModel shopModel, ShopModel tempShopModel) async {
    try {
      if (shopModel == tempShopModel) {
        throw LocaleKeys.anyThingWasNotChangedText.locale;
      }

      await FirebaseCollectionRefInitialize.instance.shopsCollectionReference
          .doc(shopModel.id)
          .update(shopModel.toMap());

      await updateEmailAddress(shopModel.email!);

      showSnackBar(scaffoldState, context, LocaleKeys.updatingIsSuccesfullyText.locale);
    } on FirebaseException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
    } catch (e) {
      showSnackBar(scaffoldState, context, e.toString());
    }
  }

  Future<ShopModel?> fetchShopData() async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();
      if (user != null) {
        final shopsListQuery = await FirebaseCollectionRefInitialize
            .instance.shopsCollectionReference
            .get();
        List<DocumentSnapshot> docsInShops = shopsListQuery.docs;
        if (docsInShops.isNotEmpty) {
          ShopModel shopModel =
              ShopModel.fromJson(docsInShops.first.data() as Map);
          return shopModel;
        }
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.errorOnFetchingShopInformationText.locale);
      return null;
    }
  }

  @override
  Future<String?> _uploadFile(File _image, User user) async {
    try {
      String storageName = "${user.uid} -> Profile Image";

      TaskSnapshot uploadImageSnapshot = await FirebaseStorageInitalize
          .instance.firabaseStorage
          .ref()
          .child("content")
          .child(user.uid)
          .child(storageName)
          .putFile(_image);

      return await uploadImageSnapshot.ref.getDownloadURL();
    } catch (e) {
      throw LocaleKeys.locationWasNotUpdatedText.locale;
    }
  }

  Future<void> updateEmailAddress(String newEmail) async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();
      if (user != null) {
        if (user.email.toString() != newEmail) {
          await user.updateEmail(newEmail);
          //   showSnackBar(scaffoldState, context, "Email updated");
        }
      }
    } catch (e) {
      showSnackBar(scaffoldState, context, LocaleKeys.errorOnUpdatingEmailText.locale);
    }
  }

  Future<void> deleteAccount() async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();
      if (user != null) {
        await FirebaseCollectionRefInitialize.instance.shopsCollectionReference
            .doc(user.uid)
            .delete();

        await FirebaseStorageInitalize.instance.firabaseStorage
            .ref("content/${user.uid}")
            .listAll()
            .then((value) {
          value.items.forEach((element) async {
            await FirebaseStorageInitalize.instance.firabaseStorage
                .ref(element.fullPath)
                .delete();
          });
        });

        final productListQuery = await FirebaseCollectionRefInitialize
            .instance.productsCollectionReference
            .where("shopId", isEqualTo: user.uid)
            .get()
            .then((value) async => {
                  for (DocumentSnapshot ds in value.docs)
                    {await ds.reference.delete()}
                });
        await user.delete();
      }
    } catch (e) {
      showSnackBar( 
          scaffoldState, context, LocaleKeys.errorOnDeletingAccountText.locale + e.toString());
    }
  }
}
