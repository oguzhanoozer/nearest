part of '../shop_owner_register_view.dart';


extension _RegisterOwnerExtension on ShopOwnerRegisterView {
  Widget buildFirstPasswordTextField(
      ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        validator: (value) =>
            value!.isNotEmpty ? null : LocaleKeys.theFieldRequiredText.locale,
        controller: viewModel.passwordFirstController,
        obscureText: viewModel.isFirstLockOpen,
        decoration: buildFirstPasswordTextFieldDecoration(context, viewModel),
      );
    });
  }

  InputDecoration buildFirstPasswordTextFieldDecoration(
      BuildContext context, ShopOwnerRegisterViewModel viewModel) {
    return InputDecoration(
      labelStyle: context.textTheme.subtitle1,
      label: Text(
        LocaleKeys.enterPasswordText.locale,
      ),
      icon: buildContainerIconField(context, Icons.vpn_key),
      hintText: LocaleKeys.passwordExampleText.locale,
      suffixIcon: TextButton(
        onPressed: () {
          viewModel.isFirstLockStateChange();
        },
        //      padding: EdgeInsets.zero,
        child: Observer(builder: (_) {
          return Icon(viewModel.isFirstLockOpen ? Icons.lock : Icons.lock_open);
        }),
      ),
    );
  }

  Widget buildLaterPasswordTextField(
      ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        validator: (value) => value!.isEmpty
            ? LocaleKeys.theFieldRequiredText.locale
            : viewModel.passwordLaterController!.text !=
                    viewModel.passwordFirstController!.text
                ? LocaleKeys.passwordNotSameText.locale
                : null,
        controller: viewModel.passwordLaterController,
        obscureText: viewModel.isLaterLockOpen,
        decoration: buildLaterPasswordTextFieldDecoration(context, viewModel),
      );
    });
  }

  InputDecoration buildLaterPasswordTextFieldDecoration(
      BuildContext context, ShopOwnerRegisterViewModel viewModel) {
    return InputDecoration(
      labelStyle: context.textTheme.subtitle1,
      label: Text(
        LocaleKeys.againPasswordText.locale,
      ),
      icon: buildContainerIconField(context, Icons.vpn_key),
      hintText: LocaleKeys.passwordExampleText.locale,
      suffixIcon: TextButton(
        onPressed: () {
          viewModel.isLaterLockStateChange();
        },
        //      padding: EdgeInsets.zero,
        child: Observer(builder: (_) {
          return Icon(viewModel.isLaterLockOpen ? Icons.lock : Icons.lock_open);
        }),
      ),
    );
  }

  TextFormField buildEmailTextField(
      ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
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
        label: Text(LocaleKeys.emailText.locale),
        icon: buildContainerIconField(context, Icons.email),
        hintText: "example@email.com");
  }

  TextFormField buildNameTextField(
      ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) =>
          value!.isNotEmpty ? null : LocaleKeys.theFieldRequiredText.locale,
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
      ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      maxLines: 3,
      validator: (value) =>
          value!.isNotEmpty ? null : LocaleKeys.theFieldRequiredText.locale,
      controller: viewModel.businessAdressController,
      decoration: buildAdressTextFieldDecoration(context),
    );
  }

  InputDecoration buildAdressTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text(LocaleKeys.businessAddressText.locale),
        icon: buildContainerIconField(context, Icons.location_on),
        hintText: LocaleKeys.firstStreetText.locale);
  }

  TextFormField buildPhoneTextField(
      ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) =>
          value!.isNotEmpty ? null : LocaleKeys.theFieldRequiredText.locale,
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

  Container buildContainerIconField(BuildContext context, IconData icon) {
    return Container(
      padding: context.paddingLow,
      child: Icon(icon, color: context.appTheme.colorScheme.onSurfaceVariant),
    );
  }
}
