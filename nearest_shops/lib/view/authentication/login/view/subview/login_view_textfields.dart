part of '../login_view.dart';

extension _LoginViewTextFields on LoginView {
  Widget buildPasswordTextField(
      LoginViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        validator: (value) =>
            value!.isNotEmpty ? null : LocaleKeys.theFieldRequired.locale,
            keyboardType: TextInputType.visiblePassword,
        controller: viewModel.passwordController,
        obscureText: viewModel.isLockOpen,
        decoration: buildPasswordTextFieldDecoration(context, viewModel),
      );
    });
  }

  InputDecoration buildPasswordTextFieldDecoration(
      BuildContext context, LoginViewModel viewModel) {
    return InputDecoration(
      labelStyle: context.textTheme.subtitle1,
      label: Text(
        LocaleKeys.password.locale,
      ),
      icon: buildContainerIconField(context, Icons.vpn_key),
      hintText: "Password123456",
      suffixIcon: TextButton(
        onPressed: () {
          viewModel.isLockStateChange();
        },
        child: Observer(builder: (_) {
          return Icon(viewModel.isLockOpen ? Icons.lock : Icons.lock_open);
        }),
      ),
    );
  }

  TextFormField buildEmailTextField(
      LoginViewModel viewModel, BuildContext context) {
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
