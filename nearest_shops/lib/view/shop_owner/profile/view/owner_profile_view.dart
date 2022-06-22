import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../authentication/change_password/view/change_password_view.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/image/image_network.dart';
import '../../../product/input_text_decoration.dart';
import '../viewmodel/owner_profile_view_model.dart';

class OwnerProfileView extends StatelessWidget {
  const OwnerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OwnerProfileViewModel>(
      viewModel: OwnerProfileViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, OwnerProfileViewModel viewModel) => buildScaffold(context, viewModel),
    );
  }

  Scaffold buildScaffold(BuildContext context, OwnerProfileViewModel viewModel) => Scaffold(
      key: viewModel.scaffoldState,
      appBar: AppBar(),
      body: Observer(builder: (_) {
        return viewModel.profileLoading
            ? CallCircularProgress(context)
            : Padding(
                padding: context.horizontalPaddingNormal * 2,
                child: Form(
                  key: viewModel.formState,
                  child: ListView(
                    children: [
                      Center(
                        child: viewModel.isImageSelected
                            ? Padding(
                                padding: context.paddingLow,
                                child: CallCircularProgress(context),
                              )
                            : buildImage(viewModel, context),
                      ),
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
                      context.emptySizedHeightBoxLow,
                      buildEmailTextField(viewModel, context),
                      context.emptySizedHeightBoxLow,
                      buildNameTextField(viewModel, context),
                      context.emptySizedHeightBoxLow,
                      buildAdressTextField(viewModel, context),
                      context.emptySizedHeightBoxLow,
                      buildPhoneTextField(viewModel, context),
                      context.emptySizedHeightBoxLow,
                      buildUpdateButton(viewModel, context),
                      context.emptySizedHeightBoxLow,
                      buildChangePasswordButton(viewModel, context),
                      context.emptySizedHeightBoxLow,
                      buildDeleteUserButton(context, viewModel),
                    ],
                  ),
                ),
              );
      }));

  Widget buildImage(OwnerProfileViewModel viewModel, BuildContext context) {
    final image = buildImageNetwork(viewModel.photoImageUrl().toString(), context, height: context.dynamicHeight(0.15), width: context.dynamicHeight(0.15));
    // final image = viewModel.photoImageUrl() == null
    //     ? Image.asset(
    //         ImagePaths.instance.icons_shoes,
    //         fit: BoxFit.cover,
    //         height: context.dynamicHeight(0.15),
    //         width: context.dynamicHeight(0.15),
    //       )
    //     : buildImageNetwork(viewModel.photoImageUrl().toString(), context);

    return viewModel.photoImageUrl() == null
        ? Icon(Icons.person, size: context.dynamicHeight(0.15), color: context.colorScheme.primary)
        : ClipOval(
            child: image,
          );
  }

  Widget buildEditIcon(OwnerProfileViewModel viewModel, BuildContext context) => GestureDetector(
      child: buildCircle(
        color: context.colorScheme.onSurfaceVariant,
        all: 8,
        child: Icon(
          Icons.edit,
          color: context.colorScheme.inversePrimary,
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

  TextFormField buildEmailTextField(OwnerProfileViewModel viewModel, BuildContext context) {
    return TextFormField(
      enabled: false,
      style: inputTextStyle(context),
      validator: (value) => value!.isNotEmpty ? null : LocaleKeys.enterValidEmailText.locale,
      keyboardType: TextInputType.emailAddress,
      controller: viewModel.emailController,
      decoration:
          buildInputDecoration(context, hintText: LocaleKeys.emailExampleText.locale, prefixIcon: Icons.email, prefixIconColor: context.colorScheme.primary),
    );
  }

  TextFormField buildNameTextField(OwnerProfileViewModel viewModel, BuildContext context) {
    return TextFormField(
      style: inputTextStyle(context),
      validator: (value) => value!.isNotEmpty ? null : LocaleKeys.enterValidEmailText.locale,
      keyboardType: TextInputType.streetAddress,
      controller: viewModel.businessNameController,
      decoration:
          buildInputDecoration(context, hintText: LocaleKeys.businessNameText.locale, prefixIcon: Icons.shop, prefixIconColor: context.colorScheme.primary),
    );
  }

  TextFormField buildAdressTextField(OwnerProfileViewModel viewModel, BuildContext context) {
    return TextFormField(
      style: inputTextStyle(context),
      keyboardType: TextInputType.streetAddress,
      maxLines: 5,
      validator: (value) => value!.isNotEmpty ? null : LocaleKeys.enterValidEmailText.locale,
      controller: viewModel.businessAdressController,
      decoration: buildInputDecoration(context,
          hintText: LocaleKeys.businessAddressText.locale, prefixIcon: Icons.location_on, prefixIconColor: context.colorScheme.primary),
    );
  }

  TextFormField buildPhoneTextField(OwnerProfileViewModel viewModel, BuildContext context) {
    return TextFormField(
      style: inputTextStyle(context),
      validator: (value) => value!.isNotEmpty ? null : LocaleKeys.enterValidEmailText.locale,
      keyboardType: TextInputType.phone,
      controller: viewModel.businessPhoneController,
      decoration:
          buildInputDecoration(context, hintText: LocaleKeys.numberExample.locale, prefixIcon: Icons.phone, prefixIconColor: context.colorScheme.primary),
    );
  }

  Widget buildUpdateButton(OwnerProfileViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return viewModel.isUpdating
          ? CallCircularProgress(context)
          : NormalButton(
              child: buildButtonText(
                LocaleKeys.updateText.locale,
                context,
              ),
              onPressed: () async {
                await viewModel.updateShopData();
              },
              color: context.appTheme.colorScheme.onSurfaceVariant,
            );
    });
  }

  Widget buildChangePasswordButton(OwnerProfileViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return NormalButton(
        child: buildButtonText(
          LocaleKeys.changePasswordText.locale,
          context,
        ),
        onPressed: () {
          Navigator.pushNamed(context, changePasswordViewRoute);
        },
        color: context.appTheme.colorScheme.onSurfaceVariant,
      );
    });
  }

  Widget buildDeleteUserButton(BuildContext context, OwnerProfileViewModel viewModel) {
    return Observer(builder: (_) {
      return NormalButton(
        child: buildButtonText(
          LocaleKeys.deleteAccountText.locale,
          context,
        ),
        onPressed: () async {
          deleteUserShowDialog(context, viewModel);
        },
        color: context.colorScheme.onPrimaryContainer,
      );
    });
  }

  Future<void> deleteUserShowDialog(BuildContext context, OwnerProfileViewModel viewModel) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: buildDeleteButtonText(LocaleKeys.areYouSureText.locale, context),
        content: buildDeleteButtonText(LocaleKeys.willYouDeleteYourAccountText.locale, context),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: buildDeleteButtonText(LocaleKeys.cancelText.locale, context),
          ),
          TextButton(
            onPressed: () async {
              await viewModel.deleteAccount();
            },
            child: buildDeleteButtonText(LocaleKeys.okText.locale, context),
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

  Text buildLabelText(String text, BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lora(textStyle: context.textTheme.titleSmall!.copyWith(color: context.colorScheme.onSurfaceVariant)),
    );
  }

  Text buildButtonText(String text, BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(color: context.colorScheme.inversePrimary)),
    );
  }

  Text buildDeleteButtonText(String text, BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lora(textStyle: context.textTheme.titleSmall!.copyWith(color: context.colorScheme.onPrimary)),
    );
  }

  TextStyle buildTextStyle(BuildContext context) {
    return GoogleFonts.lora(textStyle: context.textTheme.titleMedium!.copyWith(color: context.colorScheme.onPrimary));
  }
}
