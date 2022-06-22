import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';

part 'owner_dashboard_view_model.g.dart';

class OwnerDashboardViewModel = _OwnerDashboardViewModelBase with _$OwnerDashboardViewModel;

abstract class _OwnerDashboardViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {}
  @override
  void init() {}
}
