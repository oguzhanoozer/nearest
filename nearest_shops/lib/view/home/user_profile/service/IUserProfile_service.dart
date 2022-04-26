import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/firestorage_initialize.dart';
import '../../../utility/error_helper.dart';

abstract class IUserProfileService {
  final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IUserProfileService(this.scaffoldState, this.context);
  Future<String?> uploadProfileImage(File pickedFile);
  Future<String?> _uploadFile(File _image, User user);
  Future<void> updateEmailAddress(String newEmail);
  Future<void> deleteAccount();
}

class UserProfileService extends IUserProfileService with ErrorHelper {
  UserProfileService(
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
      showSnackBar(scaffoldState, context,LocaleKeys.errorOnUploadingProfileImagaText.locale);
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
      throw LocaleKeys.errorOnUploadingProfileImagaText.locale;
    }
  }

  Future<void> deleteAccount() async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();
      if (user != null) {
        
        await FirebaseCollectionRefInitialize.instance.usersCollectionReference
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
        await user.delete();
      }
    } catch (e) {
      showSnackBar(
          scaffoldState, context, LocaleKeys.errorOnDeletingAccountText.locale + e.toString());
    }
  }

  Future<void> updateEmailAddress(String newEmail) async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();
      if (user != null) {
        if (user.email.toString() == newEmail) {
          showSnackBar(scaffoldState, context,
              LocaleKeys.theEnterEmailAdressIsSameText.locale);
        } else {
          await user.updateEmail(newEmail);
          showSnackBar(scaffoldState, context,  LocaleKeys.emailUpdatedText.locale);
        }
      } 
    } catch (e) {
      showSnackBar(scaffoldState, context,  LocaleKeys.errorOnUpdatingEmailText.locale);
    }
  }
}
