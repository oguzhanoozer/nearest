import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/language_manager.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/theme/app_theme.dart';
import '../../../authentication/change_password/view/change_password_view.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/image/image_network.dart';
import '../../../product/input_text_decoration.dart';
import '../viewmodel/user_profile_view_model.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<UserProfileViewModel>(
      viewModel: UserProfileViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, UserProfileViewModel viewModel) => buildScaffold(context, viewModel),
    );
  }

  Scaffold buildScaffold(BuildContext context, UserProfileViewModel viewModel) => Scaffold(
        key: viewModel.scaffoldState,
        appBar: AppBar(),
        body: Observer(builder: (_) {
          return viewModel.profileLoading
              ? CallCircularProgress(context)
              : Padding(
                  padding: context.horizontalPaddingNormal * 2,
                  child: ListView(
                    children: [
                      Observer(builder: (_) {
                        return Center(
                          child: viewModel.isImageSelected
                              ? Padding(
                                  padding: context.paddingLow,
                                  child: CallCircularProgress(context),
                                )
                              : buildImage(viewModel, context),
                        );
                      }),
                      Padding(
                          padding: context.horizontalPaddingHigh,
                          child: TextButton(
                            onPressed: () async {
                              await viewModel.selectImage();
                            },
                            child: FittedBox(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(LocaleKeys.changeProfilePhoto.locale,
                                      style: GoogleFonts.lora(
                                          textStyle:
                                              context.textTheme.headline6!.copyWith(color: context.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold))),
                                  context.emptySizedWidthBoxLow,
                                  buildEditIcon(viewModel, context),
                                ],
                              ),
                            ),
                          )),
                      context.emptySizedHeightBoxNormal,
                      buildEmailTextField(viewModel, context),
                      context.emptySizedHeightBoxLow,
                      buildChangePasswordButton(viewModel, context),
                      context.emptySizedHeightBoxNormal,
                      buildLangCard(viewModel, context),
                      buildThemeCard(viewModel, context),
                      context.emptySizedHeightBoxNormal,
                      buildLogOutButton(viewModel, context),
                      context.emptySizedHeightBoxNormal,
                      buildDeleteUserButton(context, viewModel),
                    ],
                  ),
                );
        }),
      );

  Card buildThemeCard(UserProfileViewModel viewModel, BuildContext context) {
    return Card(
      child: Observer(builder: (_) {
        bool themeValue = viewModel.currentAppThemeMode == AppThemeMode.ThemeLight ? true : false;
        return ListTile(
          subtitle: themeValue
              ? Text(LocaleKeys.lightModeText.locale, style: inputTextStyle(context))
              : Text(LocaleKeys.darkModeText.locale, style: inputTextStyle(context)),
          leading: Icon(themeValue ? Icons.wb_sunny : Icons.nightlight_round, color: context.colorScheme.onSurfaceVariant),
          title: Text(LocaleKeys.themeText.locale, style: priceTextStyle(context)),
          trailing: Switch(
            activeColor: themeValue ? context.colorScheme.onSurfaceVariant : context.colorScheme.onSecondary,
            inactiveThumbColor: context.colorScheme.onSecondary,
            splashRadius: 30,
            value: themeValue,
            onChanged: (_) async {
              await viewModel.changeAppTheme();
            },
          ),
        );
      }),
    );
  }

  Card buildLangCard(UserProfileViewModel viewModel, BuildContext context) {
    return Card(
      child: Observer(builder: (_) {
        return ListTile(
          subtitle: Text(viewModel.currentLangTitle, style: inputTextStyle(context)),
          leading: Icon(Icons.language, color: context.colorScheme.onSurfaceVariant),
          title: Text(LocaleKeys.languageText.locale, style: priceTextStyle(context)),
          trailing: DropdownButton<Locale>(
            onChanged: viewModel.changeAppLanguage,
            underline: const SizedBox(),
            items: [
              DropdownMenuItem(
                  child: Text(LanguageManager.instance.enLocale.languageCode.toLowerCase(), style: inputTextStyle(context)),
                  value: LanguageManager.instance.enLocale),
              DropdownMenuItem(
                  child: Text(LanguageManager.instance.trLocale.languageCode.toLowerCase(), style: inputTextStyle(context)),
                  value: LanguageManager.instance.trLocale),
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

  Widget buildImage(UserProfileViewModel viewModel, BuildContext context) {
    final image =  buildImageNetwork(viewModel.photoImageUrl().toString(), context, height: context.dynamicHeight(0.15), width: context.dynamicHeight(0.15));
    // = viewModel.photoImageUrl() == null
    //     ? Image.asset(
    //         ImagePaths.instance.prof,
    //         fit: BoxFit.fill,
    //         height: context.dynamicHeight(0.15),
    //         width: context.dynamicHeight(0.15),
    //       )
    //     : buildImageNetwork(viewModel.photoImageUrl().toString(), context, height: context.dynamicHeight(0.15), width: context.dynamicHeight(0.15));

    return viewModel.photoImageUrl() == null
        ? Icon(Icons.person, size: context.dynamicHeight(0.15), color: context.colorScheme.primary)
        : ClipOval(
            child: image,
          );
  }

  Widget buildEditIcon(UserProfileViewModel viewModel, BuildContext context) => buildCircle(
        color: context.colorScheme.onSurfaceVariant,
        all: 8,
        child: Icon(
          Icons.edit,
          color: context.colorScheme.inversePrimary,
          size: 20,
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }

  Widget buildEmailTextField(UserProfileViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formState,
      child: TextFormField(
        enabled: false,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        style: inputTextStyle(context),
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.enterValidEmailText.locale,
        keyboardType: TextInputType.emailAddress,
        controller: viewModel.emailController,
        decoration: buildInputDecoration(context, hintText: '', prefixIcon: Icons.email),
      ),
    );
  }

  Widget buildChangePasswordButton(UserProfileViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(LocaleKeys.changePasswordText.locale,
            style: GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(color: context.colorScheme.inversePrimary, fontWeight: FontWeight.bold))),
        onPressed: () {
          Navigator.pushNamed(context, changePasswordViewRoute);
        },
        color: context.appTheme.colorScheme.onSurfaceVariant,
      );
    });
  }

  Widget buildLogOutButton(UserProfileViewModel viewModel, BuildContext context) {
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

  Widget buildDeleteUserButton(BuildContext context, UserProfileViewModel viewModel) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
          LocaleKeys.deleteAccountText.locale,
          style: GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(color: context.colorScheme.inversePrimary, fontWeight: FontWeight.bold)),
        ),
        onPressed: () async {
          deleteUserShowDialog(context, viewModel);
        },
        color: context.colorScheme.onPrimaryContainer,
      );
    });
  }

  Future<void> deleteUserShowDialog(BuildContext context, UserProfileViewModel viewModel) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          LocaleKeys.areYouSureText.locale,
          style: titleTextStyle(context),
        ),
        content: Text(LocaleKeys.willYouDeleteYourAccountText.locale, style: inputTextStyle(context)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              LocaleKeys.cancelText.locale,
              style: titleTextStyle(context),
            ),
          ),
          TextButton(
            onPressed: () async {
              await viewModel.deleteAccount();
            },
            child: Text(
              LocaleKeys.okText.locale,
              style: titleTextStyle(context),
            ),
          ),
        ],
      ),
    );
  }

  Container buildContainerIconField(BuildContext context, IconData icon) {
    return Container(
      padding: context.paddingLow,
      child: Icon(icon, color: context.appTheme.colorScheme.onSurfaceVariant),
    );
  }
}
