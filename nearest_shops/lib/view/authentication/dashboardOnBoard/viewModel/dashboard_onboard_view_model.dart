import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/view/home/dashboard/view/dashboard_view.dart';
import 'package:nearest_shops/view/shop_owner/dashboard/view/owner_dashboard_view.dart';
import 'package:nearest_shops/view/utility/error_helper.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../home/dashboard/view/home_dashboard_navigation_view.dart';
part 'dashboard_onboard_view_model.g.dart';

class DashboardOnBoardViewModel = _DashboardOnBoardViewModelBase
    with _$DashboardOnBoardViewModel;

abstract class _DashboardOnBoardViewModelBase with Store, BaseViewModel ,ErrorHelper{
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @observable
  int? _userRole;

  @observable
  bool isDashboardLoading = false;

  void setContext(BuildContext context) => this.context = context;
  void init() {
    getUserRole();
  }

  Widget directDashboard() {
    return _userRole == UserRole.USER.roleRawValue
        ? HomeDashboardNavigationView()
        : OwnerDashboardView();
  }

  @action
  Future<void> getUserRole() async {
    changeIsDashboardLoading();
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();

      if (user != null) {
        UserIdInitalize.instance.setUserId(user.uid);

        _userRole = await FirebaseAuthentication.instance.getUserRole(user.uid);
      }
    } on FirebaseAuthException catch (e) {
     showSnackBar(scaffoldState,context!, e.message.toString());
    }
    changeIsDashboardLoading();
  }

  @action
  void changeIsDashboardLoading() {
    isDashboardLoading = !isDashboardLoading;
  }
}
