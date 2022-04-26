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
import '../../../authentication/change_password/view/change_password_view.dart';
import '../../../product/contstants/image_path.dart';
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
      onPageBuilder: (context, UserProfileViewModel viewModel) =>
          buildScaffold(context, viewModel),
    );
  }

  Scaffold buildScaffold(
          BuildContext context, UserProfileViewModel viewModel) =>
      Scaffold(
        key: viewModel.scaffoldState,
        appBar: AppBar(),
        body: Observer(builder: (_) {
          return viewModel.profileLoading
              ? const CircularProgressIndicator()
              : Padding(
                  padding: context.horizontalPaddingNormal * 2,
                  child: ListView(
                    children: [
                      Center(
                        child: viewModel.isImageSelected
                            ? CircularProgressIndicator()
                            : Stack(
                                children: [
                                  buildImage(viewModel),
                                  Positioned(
                                    bottom: 0,
                                    right: 4,
                                    child:
                                        buildEditIcon(viewModel,context),
                                  ),
                                ],
                              ),
                      ),
                      context.emptySizedHeightBoxNormal,
                      buildEmailTextField(viewModel, context),
                      // context.emptySizedHeightBoxLow,
                      //buildUpdateButton(viewModel, context),
                      context.emptySizedHeightBoxLow,
                      buildChangePasswordButton(viewModel, context),
                      context.emptySizedHeightBoxNormal,
                      buildLangCard(viewModel,context),
                      buildThemeCard(viewModel,context),
                      context.emptySizedHeightBoxNormal,
                      buildLogOutButton(context),
                      context.emptySizedHeightBoxNormal,
                      buildDeleteUserButton(context, viewModel),
                    ],
                  ),
                );
        }),
      );

  Card buildThemeCard(UserProfileViewModel viewModel,BuildContext context) {
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
            splashRadius: 30,
            value: themeValue,
            onChanged: (_) {
              viewModel.changeAppTheme();
            },
          ),
        );
      }),
    );
  }

  Card buildLangCard(UserProfileViewModel viewModel,BuildContext context) {
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
              color: context.colorScheme.onSurfaceVariant
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

  Widget buildImage(UserProfileViewModel viewModel) {
    final image = viewModel.photoImageUrl() == null
        ? Image.asset(
            ImagePaths.instance.cars,
            fit: BoxFit.fill,
            height: 120,
            width: 120,
          )
        : Image.network(
            viewModel.photoImageUrl().toString(),
            fit: BoxFit.fill,
            height: 120,
            width: 120,
          );

    return ClipOval(
      child: image,
    );
  }

  Widget buildEditIcon( UserProfileViewModel viewModel,BuildContext context) =>
      GestureDetector(
          child: buildCircle(
            color: context.colorScheme.onSurfaceVariant,
            all: 8,
            child: Icon(
              Icons.edit,
              color: context.colorScheme.onSecondary,
              size: 20,
            ),
          ),
          onTap: () async {
            await viewModel.selectImage();
          });

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

  Widget buildEmailTextField(
      UserProfileViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formState,
      child: TextFormField(
        enabled: false,
        validator: (value) =>
            value!.isNotEmpty ? null : LocaleKeys.enterValidEmailText.locale,
        keyboardType: TextInputType.emailAddress,
        controller: viewModel.emailController,
        decoration: buildEmailTextFieldDecoration(context),
      ),
    );
  }

  InputDecoration buildEmailTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        //  label: Text(LocaleKeys.email.locale),
        icon: buildContainerIconField(context, Icons.email),
        hintText: "example@email.com");
  }

  Widget buildUpdateButton(
      UserProfileViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
           LocaleKeys.updateEmailText.locale,
          style: context.textTheme.headline6!
              .copyWith(color: context.colorScheme.onSecondary),
        ),
        onPressed: () async {
          await viewModel.updateEmailAddress();
        },
        color: context.appTheme.colorScheme.onSurfaceVariant,
      );
    });
  }

  Widget buildChangePasswordButton(
      UserProfileViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
           LocaleKeys.changePasswordText.locale,
          style: context.textTheme.headline6!
              .copyWith(color: context.colorScheme.onSecondary),
        ),
        onPressed: () {
          context.navigateToPage(ChangePasswordView());
        },
        color: context.appTheme.colorScheme.onSurfaceVariant,
      );
    });
  }

  Widget buildLogOutButton(BuildContext context) {
    return Observer(builder: (_) {
      return NormalButton(
        child:

            Text(
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

  Widget buildDeleteUserButton(
      BuildContext context, UserProfileViewModel viewModel) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
           LocaleKeys.deleteAccountText.locale,
          style: context.textTheme.headline6!
              .copyWith(color: context.colorScheme.onSecondary),
        ),
        onPressed: () async {
          deleteUserShowDialog(context, viewModel);
        },
        color:context.colorScheme.onPrimaryContainer,
      );
    });
  }

  Future<void> deleteUserShowDialog(
      BuildContext context, UserProfileViewModel viewModel) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text( LocaleKeys.areYouSureText.locale),
        content: Text( LocaleKeys.willYouDeleteYourAccountText.locale),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child:  Text( LocaleKeys.cancelText.locale),
          ),
          TextButton(
            onPressed: () async {
              await viewModel.deleteAccount();
            },
            child: const Text("OK"),
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
