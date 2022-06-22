part of '../register_view.dart';

extension _RegisterViewTextFields on RegisterView {
  Widget buildFirstPasswordTextField(RegisterViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
          keyboardType: TextInputType.visiblePassword,
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
              child: Observer(
                builder: (_) {
                  return Icon(viewModel.isFirstLockOpen ? Icons.visibility_off : Icons.visibility);
                },
              ),
            ),
          ));
    });
  }

  Widget buildLaterPasswordTextField(RegisterViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        validator: (value) => value!.isEmpty
            ? LocaleKeys.theFieldRequiredText.locale
            : viewModel.passwordLaterController!.text != viewModel.passwordFirstController!.text
                ? LocaleKeys.passwordNotSameText.locale
                : null,
        keyboardType: TextInputType.visiblePassword,
        controller: viewModel.passwordLaterController,
        obscureText: viewModel.isLaterLockOpen,
        decoration: buildInputDecoration(context,
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
            )),
      );
    });
  }

  TextFormField buildEmailTextField(RegisterViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) => value!.isValidEmail ? null : LocaleKeys.enterValidEmailText.locale,
      keyboardType: TextInputType.emailAddress,
      controller: viewModel.emailController,
      decoration:
          buildInputDecoration(context, hintText: LocaleKeys.emailExampleText.locale, prefixIcon: Icons.email, prefixIconColor: context.colorScheme.primary),
    );
  }
}
