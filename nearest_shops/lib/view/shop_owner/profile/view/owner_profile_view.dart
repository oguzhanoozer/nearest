import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../authentication/change_password/view/change_password_view.dart';
import '../../../product/contstants/image_path.dart';
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
      onPageBuilder: (context, OwnerProfileViewModel viewModel) =>
          buildScaffold(context, viewModel),
    );
  }

  Scaffold buildScaffold(
          BuildContext context, OwnerProfileViewModel viewModel) =>
      Scaffold(
          key: viewModel.scaffoldState,
          appBar: AppBar(),
          body: Observer(builder: (_) {
            return viewModel.profileLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: context.horizontalPaddingNormal * 2,
                    child: Form(
                      key: viewModel.formState,
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
                                            buildEditIcon(viewModel, context),
                                      ),
                                    ],
                                  ),
                          ),
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

  Widget buildImage(OwnerProfileViewModel viewModel) {
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

  Widget buildEditIcon(OwnerProfileViewModel viewModel, BuildContext context) =>
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

  TextFormField buildEmailTextField(
      OwnerProfileViewModel viewModel, BuildContext context) {
    return TextFormField(
      enabled: false,
      validator: (value) =>
          value!.isNotEmpty ? null : LocaleKeys.enterValidEmailText.locale,
      keyboardType: TextInputType.emailAddress,
      controller: viewModel.emailController,
      decoration: buildEmailTextFieldDecoration(context),
    );
  }

  InputDecoration buildEmailTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        //  label: Text(LocaleKeys.email.locale),
        icon: buildContainerIconField(context, Icons.email),
        hintText: "example@email.com");
  }

  TextFormField buildNameTextField(
      OwnerProfileViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) =>
          value!.isNotEmpty ? null : LocaleKeys.enterValidEmailText.locale,
      keyboardType: TextInputType.streetAddress,
      controller: viewModel.businessNameController,
      decoration: buildNameTextFieldDecoration(context),
    );
  }

  InputDecoration buildNameTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text(LocaleKeys.businessNameText.locale),
        icon: buildContainerIconField(context, Icons.shop),
        hintText: LocaleKeys.businessNameText.locale);
  }

  TextFormField buildAdressTextField(
      OwnerProfileViewModel viewModel, BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      maxLines: 3,
      validator: (value) =>
          value!.isNotEmpty ? null : LocaleKeys.enterValidEmailText.locale,
      controller: viewModel.businessAdressController,
      decoration: buildAdressTextFieldDecoration(context),
    );
  }

  InputDecoration buildAdressTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text(LocaleKeys.businessNameText.locale),
        icon: buildContainerIconField(context, Icons.location_on),
        hintText: LocaleKeys.businessNameText.locale);
  }

  TextFormField buildPhoneTextField(
      OwnerProfileViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) =>
          value!.isNotEmpty ? null : LocaleKeys.enterValidEmailText.locale,
      keyboardType: TextInputType.phone,
      controller: viewModel.businessPhoneController,
      decoration: buildPhoneTextFieldDecoration(context),
    );
  }

  InputDecoration buildPhoneTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text(LocaleKeys.businessPhoneNumberText.locale),
        icon: buildContainerIconField(context, Icons.phone),
        hintText: "05987654321");
  }

  Widget buildUpdateButton(
      OwnerProfileViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
          LocaleKeys.updateText.locale,
          style: context.textTheme.headline6!
              .copyWith(color: context.colorScheme.onSecondary),
        ),
        onPressed: () async {
          await viewModel.updateShopData();
        },
        color: context.appTheme.colorScheme.onSurfaceVariant,
      );
    });
  }

  Widget buildChangePasswordButton(
      OwnerProfileViewModel viewModel, BuildContext context) {
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

  Widget buildDeleteUserButton(
      BuildContext context, OwnerProfileViewModel viewModel) {
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
        color: context.colorScheme.onPrimaryContainer,
      );
    });
  }

  Future<void> deleteUserShowDialog(
      BuildContext context, OwnerProfileViewModel viewModel) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LocaleKeys.areYouSureText.locale),
        content: Text(LocaleKeys.willYouDeleteYourAccountText.locale),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(LocaleKeys.cancelText.locale),
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
