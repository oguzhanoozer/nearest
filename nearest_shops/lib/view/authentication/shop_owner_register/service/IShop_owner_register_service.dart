import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../../core/init/service/firestorage/firestore_service.dart';
import '../../login/view/login_view.dart';

abstract class IShopOwnerRegisterService {
 final GlobalKey<ScaffoldState> scaffoldState;
  final BuildContext context;

  IShopOwnerRegisterService(this.scaffoldState, this.context);

  Future<void> shopOwnerRegister(
      {required String email,
      required String password,
      required Map<String, dynamic> ownerMapData});
}

class ShopOwnerRegisterService extends IShopOwnerRegisterService
    with ErrorHelper {
  ShopOwnerRegisterService(GlobalKey<ScaffoldState> scaffoldState, BuildContext context) : super(scaffoldState, context);

  @override
  Future<void> shopOwnerRegister(
      {required String email,
      required String password,
      required Map<String, dynamic> ownerMapData}) async {
    try {
      final user = await FirebaseAuthentication.instance
          .createUserWithEmailandPassword(email: email, password: password);

      if (user != null) {
        ownerMapData["id"] = user.uid;

        await FirestoreService.instance.registerOwner(ownerMapData);

        await FirebaseAuthentication.instance
            .setUserRole(UserRole.BUSINESS.roleRawValue, user.uid);
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
        await FirebaseAuthentication.instance.signOut();
        await showVerificationAlertDialog(context);
        context.navigateToPage(LoginView());
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(scaffoldState, context, e.message.toString());
    } catch (e) {
      showSnackBar(scaffoldState, context, e.toString());
    }
  }
}
