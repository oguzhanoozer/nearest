import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nearest_shops/view/authentication/dashboardOnBoard/viewModel/dashboard_onboard_view_model.dart';

import '../../../../core/base/view/base_view.dart';

class DashboardOnBoardView extends StatelessWidget {
  DashboardOnBoardView({Key? key}) : super(key: key);

  DashboardOnBoardViewModel onBoardViewModel = DashboardOnBoardViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardOnBoardViewModel>(
        viewModel: DashboardOnBoardViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder:
            (BuildContext context, DashboardOnBoardViewModel viewModel) {
          return buildScaffold(context, viewModel);
        });
  }

  Observer buildScaffold(
      BuildContext context, DashboardOnBoardViewModel viewModel) {
    return Observer(builder: (_) {
      return Scaffold(
        key: viewModel.scaffoldState,
        body: viewModel.isDashboardLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : viewModel.directDashboard(),
      );
    });
  }
}
