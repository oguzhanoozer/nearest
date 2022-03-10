part of '../shop_owner_register_view.dart';

extension _RegisterOwnerExtension on ShopOwnerRegisterView {
  Widget buildFirstPasswordTextField(
      ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        ///validator: (value) =>             value!.isNotEmpty ? null : LocaleKeys.theFieldRequired.locale,
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
        LocaleKeys.enterPassword.locale,
      ),
      icon: buildContainerIconField(context, Icons.vpn_key),
      hintText: "Password123456",
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
            ? LocaleKeys.theFieldRequired.locale
            : viewModel.passwordLaterController!.text !=
                    viewModel.passwordFirstController!.text
                ? "Passwords are not equals"
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
        LocaleKeys.againPassword.locale,
      ),
      icon: buildContainerIconField(context, Icons.vpn_key),
      hintText: "Password123456",
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
          value!.isValidEmail ? null : LocaleKeys.enterValidEmail.locale,
      keyboardType: TextInputType.emailAddress,
      controller: viewModel.emailController,
      decoration: buildEmailTextFieldDecoration(context),
    );
  }

  InputDecoration buildEmailTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text(LocaleKeys.email.locale),
        icon: buildContainerIconField(context, Icons.email),
        hintText: "example@email.com");
  }

  TextFormField buildNameTextField(
      ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) {},
      keyboardType: TextInputType.streetAddress,
      controller: viewModel.businessNameController,
      decoration: buildNameTextFieldDecoration(context),
    );
  }

  InputDecoration buildNameTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text("Business Name"),
        icon: buildContainerIconField(context, Icons.shop),
        hintText: "A Shop");
  }

  TextFormField buildAdressTextField(
      ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      maxLines: 3,
      validator: (value) {},
      controller: viewModel.businessAdressController,
      decoration: buildAdressTextFieldDecoration(context),
    );
  }

  InputDecoration buildAdressTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text("Business Address"),
        icon: buildContainerIconField(context, Icons.location_on),
        hintText: "1. Street");
  }

  TextFormField buildPhoneTextField(
      ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) {},
      keyboardType: TextInputType.phone,
      controller: viewModel.businessPhoneController,
      decoration: buildPhoneTextFieldDecoration(context),
    );
  }

  InputDecoration buildPhoneTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text("Business Phone Number"),
        icon: buildContainerIconField(context, Icons.phone),
        hintText: "05987654321");
  }

  Container buildContainerIconField(BuildContext context, IconData icon) {
    return Container(
      // color: context.colors.onError,
      padding: context.paddingLow,
      child: Icon(icon, color: context.appTheme.colorScheme.onSurfaceVariant),
    );
  }
}
