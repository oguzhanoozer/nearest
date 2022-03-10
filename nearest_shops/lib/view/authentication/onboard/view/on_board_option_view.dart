import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/authentication/register/view/register_view.dart';
import 'package:nearest_shops/view/authentication/shop_owner_register/view/shop_owner_register_view.dart';
import '../../../../core/components/button/normal_button.dart';

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
              "Next",
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
              "Login",
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
