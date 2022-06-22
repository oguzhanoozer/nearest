import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/language_manager.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/theme/app_theme.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/input_text_decoration.dart';
import '../../profile/view/owner_profile_view.dart';
import '../viewmodel/shop_owner_settings_view_model.dart';

class ShopOwnerSettingsView extends StatelessWidget {
  const ShopOwnerSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ShopOwnerSettingsViewModel>(
      viewModel: ShopOwnerSettingsViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, ShopOwnerSettingsViewModel viewModel) => buildScaffold(context, viewModel),
    );
  }

  Scaffold buildScaffold(BuildContext context, ShopOwnerSettingsViewModel viewModel) => Scaffold(
        appBar: AppBar(),
        body: Observer(builder: (_) {
          return Padding(
            padding: context.horizontalPaddingNormal * 2,
            child: ListView(
              children: [
                buildLangCard(viewModel, context),
                buildThemeCard(viewModel, context),
                context.emptySizedHeightBoxNormal,
                buildProfilePageButton(context),
                context.emptySizedHeightBoxNormal,
                buildLogOutButton(viewModel, context),
              ],
            ),
          );
        }),
      );

  Card buildThemeCard(ShopOwnerSettingsViewModel viewModel, BuildContext context) {
    return Card(
      child: Observer(builder: (_) {
        bool themeValue = context.watch<ThemeManager>().currentThemeData == AppThemeMode.ThemeLight ? true : false;
        return ListTile(
          subtitle: themeValue ? buildbuttonText(LocaleKeys.lightModeText.locale, context) : buildbuttonText(LocaleKeys.darkModeText.locale, context),
          leading: Icon(themeValue ? Icons.wb_sunny : Icons.nightlight_round, color: context.colorScheme.onSurfaceVariant),
          title: buildTitletext(LocaleKeys.themeText.locale, context),
          trailing: Switch(
            activeColor: themeValue ? context.colorScheme.onSurfaceVariant : context.colorScheme.onSecondary,
            inactiveThumbColor: context.colorScheme.onSecondary,
            value: themeValue,
            onChanged: (_) async {
              await viewModel.changeAppTheme();
            },
          ),
        );
      }),
    );
  }

  Text buildbuttonText(String text, BuildContext context) => Text(
        text,
        style: inputTextStyle(context),
      );

  Card buildLangCard(ShopOwnerSettingsViewModel viewModel, BuildContext context) {
    return Card(
      child: Observer(builder: (_) {
        return ListTile(
          subtitle: buildbuttonText(viewModel.currentLangTitle, context),
          leading: Icon(Icons.language, color: context.colorScheme.onSurfaceVariant),
          title: buildTitletext(LocaleKeys.languageText.locale, context),
          trailing: DropdownButton<Locale>(
            onChanged: viewModel.changeAppLanguage,
            underline: const SizedBox(),
            items: [
              DropdownMenuItem(
                  child: buildTitletext(LanguageManager.instance.enLocale.languageCode.toLowerCase(), context), value: LanguageManager.instance.enLocale),
              DropdownMenuItem(
                  child: buildTitletext(LanguageManager.instance.trLocale.languageCode.toLowerCase(), context), value: LanguageManager.instance.trLocale),
            ],
            icon: Icon(Icons.keyboard_arrow_right, color: context.colorScheme.onSurfaceVariant),
            elevation: 0,
            isDense: false,
            enableFeedback: false,
          ),
          dense: false,
        );
      }),
    );
  }

  Text buildTitletext(String text, BuildContext context) => Text(text, style: priceTextStyle(context));

  Text buildSubtitleText(String text, BuildContext context) => Text(
        text,
        style: inputTextStyle(context),
      );

  Widget buildProfilePageButton(BuildContext context) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
          LocaleKeys.profileSettingsText.locale,
          style: GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(color: context.colorScheme.inversePrimary, fontWeight: FontWeight.bold)),
        ),
        onPressed: () {
      Navigator.pushNamed(context, ownerProfileViewRoute);
        },
        color: context.appTheme.colorScheme.onSurfaceVariant,
      );
    });
  }

  Widget buildLogOutButton(ShopOwnerSettingsViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return viewModel.isLogOut
          ? CallCircularProgress(context)
          : NormalButton(
              child: Text(
                LocaleKeys.logOutText.locale,
                style:
                    GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(color: context.colorScheme.inversePrimary, fontWeight: FontWeight.bold)),
              ),
              onPressed: () async {
                await viewModel.logOut();
              },
              color: context.appTheme.colorScheme.onSurfaceVariant,
            );
    });
  }
}
