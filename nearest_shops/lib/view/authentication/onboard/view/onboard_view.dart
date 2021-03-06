import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../dashboardOnBoard/view/dashboard_onboard_view.dart';
import '../../login/view/login_view.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuthentication.instance.authUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.data != null ? DashboardOnBoardView() : LoginView();
        } else {
          return Center(
            child: SizedBox(height: context.normalValue, width: context.normalValue, child: CallCircularProgress(context)),
          );
        }
      },
    );
  }
}
