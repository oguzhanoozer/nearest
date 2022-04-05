import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/components/button/normal_button.dart';
import '../../register/view/register_view.dart';
import '../../shop_owner_register/view/shop_owner_register_view.dart';

class OnBoardOptionView extends StatelessWidget {
  const OnBoardOptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Do you have own business?",
            style: context.textTheme.headline5,
          ),
          Text(
            "Please create business account",
            style: context.textTheme.headline6,
          ),
          NormalButton(
            child: Text(
              "Create Business Account",
              style: context.textTheme.headline6!
                  .copyWith(color: context.colorScheme.onSecondary),
            ),
            onPressed: () {
              context.navigateToPage(ShopOwnerRegisterView());
            },
            color: context.appTheme.colorScheme.onSurfaceVariant,
          ),
          context.emptySizedHeightBoxLow3x,
          Text(
            "If you are a user, please login",
            style: context.textTheme.headline6,
          ),
          NormalButton(
            child: Text(
              "Register",
              style: context.textTheme.headline6!
                  .copyWith(color: context.colorScheme.onSecondary),
            ),
            onPressed: () {
              context.navigateToPage(RegisterView());
            },
            color: context.appTheme.colorScheme.onSurfaceVariant,
          ),
        ],
      )),
    );
  }
}
