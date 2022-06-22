import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';

import '../../../../core/components/button/button_shadow.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/contstants/image_path.dart';
import '../../register/view/register_view.dart';
import '../../shop_owner_register/view/shop_owner_register_view.dart';

class OnBoardOptionView extends StatelessWidget {
  const OnBoardOptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: FormColumn(
        children: [
          SizedBox(
            height: context.dynamicHeight(0.3),
            width: context.dynamicWidth(0.9),
            child: Lottie.asset(
              ImagePaths.instance.loti_1,
              repeat: true,
              reverse: true,
              animate: true,
            ),
          ),
          context.emptySizedHeightBoxHigh,
          Text(
            LocaleKeys.doYouHaveOwnBusinessText.locale,
            style: GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.w500, color: context.colorScheme.primary)),
          ),
          context.emptySizedHeightBoxLow,
          ButtonShadow(
            onTap: () {
              Navigator.pushNamed(context, shopOwnerRegisterViewRoute);
            },
            child: Text(
              LocaleKeys.createBusinessAccountButtonText.locale,
              style:
                  GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.onSurfaceVariant)),
            ),
          ),
          context.emptySizedHeightBoxNormal,
          Text(
            LocaleKeys.ifYouAreAuserPLeaseLoginText.locale,
            style: GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.w500, color: context.colorScheme.primary)),
          ),
          context.emptySizedHeightBoxLow,
          ButtonShadow(
            onTap: () {
              Navigator.pushNamed(context, registerViewRoute);
            },
            child: Text(
              LocaleKeys.registerButtonText.locale,
              style:
                  GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.onSurfaceVariant)),
            ),
          ),
        ],
      )),
    );
  }
}
