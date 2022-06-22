part of '../shop_owner_register_view.dart';

extension _RegisterOwnerExtension on ShopOwnerRegisterView {
  Widget buildFirstPasswordTextField(ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        style: inputTextStyle(context),
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.theFieldRequiredText.locale,
        controller: viewModel.passwordFirstController,
        obscureText: viewModel.isFirstLockOpen,
        decoration: buildInputDecoration(
          context,
          hintText: LocaleKeys.passwordExampleText.locale,
          prefixIcon: Icons.lock,
          prefixIconColor: context.colorScheme.primary,
          suffixIcon: TextButton(
            onPressed: () {
              viewModel.isFirstLockStateChange();
            },
            child: Observer(builder: (_) {
              return Icon(viewModel.isFirstLockOpen ? Icons.visibility_off : Icons.visibility);
            }),
          ),
        ),
      );
    });
  }

  Widget buildLaterPasswordTextField(ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        style: inputTextStyle(context),
        validator: (value) => value!.isEmpty
            ? LocaleKeys.theFieldRequiredText.locale
            : viewModel.passwordLaterController!.text != viewModel.passwordFirstController!.text
                ? LocaleKeys.passwordNotSameText.locale
                : null,
        controller: viewModel.passwordLaterController,
        obscureText: viewModel.isLaterLockOpen,
        decoration: buildInputDecoration(
          context,
          hintText: LocaleKeys.passwordExampleText.locale,
          prefixIcon: Icons.lock,
          prefixIconColor: context.colorScheme.primary,
          suffixIcon: TextButton(
            onPressed: () {
              viewModel.isLaterLockStateChange();
            },
            child: Observer(builder: (_) {
              return Icon(viewModel.isLaterLockOpen ? Icons.visibility_off : Icons.visibility);
            }),
          ),
        ),
      );
    });
  }

  TextFormField buildEmailTextField(ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
        style: inputTextStyle(context),
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.enterValidEmailText.locale,
        keyboardType: TextInputType.emailAddress,
        controller: viewModel.emailController,
        decoration:
            buildInputDecoration(context, hintText: LocaleKeys.emailExampleText.locale, prefixIcon: Icons.email, prefixIconColor: context.colorScheme.primary));
  }

  TextFormField buildNameTextField(ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
        style: inputTextStyle(context),
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.theFieldRequiredText.locale,
        keyboardType: TextInputType.streetAddress,
        controller: viewModel.businessNameController,
        decoration:
            buildInputDecoration(context, hintText: LocaleKeys.businessNameText.locale, prefixIcon: Icons.shop, prefixIconColor: context.colorScheme.primary));
  }

  TextFormField buildAdressTextField(ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
        style: inputTextStyle(context),
        keyboardType: TextInputType.streetAddress,
        maxLines: 5,
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.theFieldRequiredText.locale,
        controller: viewModel.businessAdressController,
        decoration: buildInputDecoration(context,
            hintText: LocaleKeys.firstStreetText.locale, prefixIcon: Icons.location_on, prefixIconColor: context.colorScheme.primary));
  }

  TextFormField buildPhoneTextField(ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
        style: inputTextStyle(context),
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.theFieldRequiredText.locale,
        keyboardType: TextInputType.phone,
        controller: viewModel.businessPhoneController,
        decoration: buildInputDecoration(context, hintText: LocaleKeys.numberExample.locale, prefixIcon: Icons.phone, prefixIconColor: context.colorScheme.primary));
  }
}
