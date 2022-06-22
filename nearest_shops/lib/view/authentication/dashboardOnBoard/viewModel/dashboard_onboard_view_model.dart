import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/model/home_dashboard_navigation_arg.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/service/authenticaion/user_id_initialize.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../home/dashboard/view/home_dashboard_navigation_view.dart';
import '../../../shop_owner/dashboard/view/owner_dashboard_view.dart';
import '../../../utility/error_helper.dart';

part 'dashboard_onboard_view_model.g.dart';

class DashboardOnBoardViewModel = _DashboardOnBoardViewModelBase with _$DashboardOnBoardViewModel;

abstract class _DashboardOnBoardViewModelBase with Store, BaseViewModel, ErrorHelper {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @observable
  int? _userRole;

  @observable
  bool isDashboardLoading = false;

  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    getUserRole();
  }

  Widget directDashboard() {
    return _userRole == UserRole.USER.roleRawValue
        ? HomeDashboardNavigationView(
            homeDashboardNavigationArg: HomeDashboardNavigationArg(null, isDirection: false),
          )
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
    } catch (e) {
      showSnackBar(scaffoldState, context!, LocaleKeys.loginError.locale);
    }
    changeIsDashboardLoading();
  }

  @action
  void changeIsDashboardLoading() {
    isDashboardLoading = !isDashboardLoading;
  }
}
