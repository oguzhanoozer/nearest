import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/init/service/firebase_authentication.dart';
import '../../../home/dashboard/view/dashboard_view.dart';
import '../../login/view/login_view.dart';

class OnBoardView extends StatelessWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuthentication.instance.authUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.data != null ? DashboardView() : LoginView();
        } else {
          return Center(
            child: SizedBox(
              height: context.normalValue,
              width: context.normalValue,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
