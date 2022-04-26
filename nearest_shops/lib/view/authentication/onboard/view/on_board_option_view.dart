import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/components/button/normal_button.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
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
            
            LocaleKeys.doYouHaveOwnBusinessText.locale,
            style: context.textTheme.headline5,
          ),
          NormalButton(
            child: Text(
              LocaleKeys.createBusinessAccountButtonText.locale,
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
            LocaleKeys.ifYouAreAuserPLeaseLoginText.locale,
            style: context.textTheme.headline6,
          ),
          NormalButton(
            child: Text(
              LocaleKeys.registerButtonText.locale,
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
