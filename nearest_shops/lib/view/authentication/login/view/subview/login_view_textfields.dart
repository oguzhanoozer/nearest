part of '../login_view.dart';

extension _LoginViewTextFields on LoginView {
  Widget buildPasswordTextField(LoginViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        style: inputTextStyle(context),
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.theFieldRequiredText.locale,
        keyboardType: TextInputType.visiblePassword,
        controller: viewModel.passwordController,
        obscureText: viewModel.isLockOpen,
        decoration: buildInputDecoration(
          context,
          hintText: LocaleKeys.passwordExampleText.locale,
          prefixIcon: Icons.lock_open,
          prefixIconColor: context.colorScheme.primary,
          suffixIcon: TextButton(
            onPressed: () {
              viewModel.isLockStateChange();
            },
            child: Observer(
              builder: (_) {
                return Icon(viewModel.isLockOpen ? Icons.visibility_off : Icons.visibility);
              },
            ),
          ),
        ),
      );
    });
  }

  TextFormField buildEmailTextField(LoginViewModel viewModel, BuildContext context) {
    return TextFormField(
      style: inputTextStyle(context),
      validator: (value) => value!.isValidEmail ? null : LocaleKeys.enterValidEmailText.locale,
      keyboardType: TextInputType.emailAddress,
      controller: viewModel.emailController,
      decoration:
          buildInputDecoration(context, hintText: LocaleKeys.emailExampleText.locale, prefixIcon: Icons.email, prefixIconColor: context.colorScheme.primary),
    );
  }
}
