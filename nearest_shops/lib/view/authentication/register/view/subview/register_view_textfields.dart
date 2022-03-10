part of '../register_view.dart';

extension _RegisterViewTextFields on RegisterView {
  Widget buildFirstPasswordTextField(
      RegisterViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        ///validator: (value) =>             value!.isNotEmpty ? null : LocaleKeys.theFieldRequired.locale,
        keyboardType: TextInputType.visiblePassword,
        controller: viewModel.passwordFirstController,
        obscureText: viewModel.isFirstLockOpen,
        decoration: buildFirstPasswordTextFieldDecoration(context, viewModel),
      );
    });
  }

  InputDecoration buildFirstPasswordTextFieldDecoration(
      BuildContext context, RegisterViewModel viewModel) {
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
        child: Observer(builder: (_) {
          return Icon(viewModel.isFirstLockOpen ? Icons.lock : Icons.lock_open);
        }),
      ),
    );
  }

  Widget buildLaterPasswordTextField(
      RegisterViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        validator: (value) => value!.isEmpty
            ? LocaleKeys.theFieldRequired.locale
            : viewModel.passwordLaterController!.text !=
                    viewModel.passwordFirstController!.text
                ? "Passwords are not equals"
                : null,
        keyboardType: TextInputType.visiblePassword,
        controller: viewModel.passwordLaterController,
        obscureText: viewModel.isLaterLockOpen,
        decoration: buildLaterPasswordTextFieldDecoration(context, viewModel),
      );
    });
  }

  InputDecoration buildLaterPasswordTextFieldDecoration(
      BuildContext context, RegisterViewModel viewModel) {
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
      RegisterViewModel viewModel, BuildContext context) {
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

  Container buildContainerIconField(BuildContext context, IconData icon) {
    return Container(
      // color: context.colors.onError,
      padding: context.paddingLow,
      child: Icon(icon, color: context.appTheme.colorScheme.onSurfaceVariant),
    );
  }
}
