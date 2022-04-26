import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/language_manager.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/theme/app_theme.dart';
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
      onPageBuilder: (context, ShopOwnerSettingsViewModel viewModel) =>
          buildScaffold(context, viewModel),
    );
  }

  Scaffold buildScaffold(
          BuildContext context, ShopOwnerSettingsViewModel viewModel) =>
      Scaffold(
        appBar: AppBar(),
        body: Observer(builder: (_) {
          return Padding(
            padding: context.horizontalPaddingNormal * 2,
            child: ListView(
              children: [
                buildLangCard(viewModel,context),
                buildThemeCard(viewModel,context),
                context.emptySizedHeightBoxNormal,
                buildProfilePageButton(context),
                context.emptySizedHeightBoxNormal,
                buildLogOutButton(context),
              ],
            ),
          );
        }),
      );

  Card buildThemeCard(ShopOwnerSettingsViewModel viewModel,BuildContext context) {
    return Card(
      child: Observer(builder: (_) {
        bool themeValue =
            viewModel.currentAppThemeMode == AppThemeMode.ThemeLight
                ? true
                : false;
        return ListTile(
          subtitle: themeValue ? Text(LocaleKeys.lightModeText.locale) : Text(LocaleKeys.darkModeText.locale),
          leading: Icon(
            themeValue ? Icons.wb_sunny : Icons.nightlight_round,
            color: context.colorScheme.onSurfaceVariant
          ),
          title: Text(LocaleKeys.themeText.locale),
          trailing: Switch(
            activeColor: themeValue ? context.colorScheme.onSurfaceVariant : context.colorScheme.onSecondary,
            

            inactiveThumbColor: context.colorScheme.onSecondary,
            value: themeValue,
            onChanged: (_) {
              viewModel.changeAppTheme();
            },
          ),
        );
      }),
    );
  }

  Card buildLangCard(ShopOwnerSettingsViewModel viewModel,BuildContext context) {
    return Card(
      child: Observer(builder: (_) {
        return ListTile(
          subtitle: Text(viewModel.currentLangTitle),
          leading: Icon(
            Icons.language,
            color: context.colorScheme.onSurfaceVariant
          ),
          title: Text(LocaleKeys.languageText.locale),
          trailing: DropdownButton<Locale>(
            ///value: viewModel.appLocale,
            onChanged: viewModel.changeAppLanguage,
            underline: SizedBox(),
            items: [
              DropdownMenuItem(
                  child: Text(LanguageManager.instance.enLocale.languageCode
                      .toLowerCase()),
                  value: LanguageManager.instance.enLocale),
              DropdownMenuItem(
                  child: Text(LanguageManager.instance.trLocale.languageCode
                      .toLowerCase()),
                  value: LanguageManager.instance.trLocale),
            ],
            icon: Icon(
              Icons.keyboard_arrow_right,
              color:context.colorScheme.onSurfaceVariant
            ),
            elevation: 0,
            isDense: false,
            enableFeedback: false,
          ),
          dense: false,
        );
      }),
    );
  }

  Widget buildProfilePageButton(BuildContext context) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
         LocaleKeys.profileSettingsText.locale,
          style: context.textTheme.headline6!
              .copyWith(color: context.colorScheme.onSecondary),
        ),
        onPressed: () {
          context.navigateToPage(OwnerProfileView());
        },
        color: context.appTheme.colorScheme.onSurfaceVariant,
      );
    });
  }

  Widget buildLogOutButton(BuildContext context) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
          LocaleKeys.logOutText.locale,
          style: context.textTheme.headline6!
              .copyWith(color: context.colorScheme.onSecondary),
        ),
        onPressed: () async {
          await FirebaseAuthentication.instance.signOut();
        },
        color: context.appTheme.colorScheme.onSurfaceVariant,
      );
    });
  }
}
