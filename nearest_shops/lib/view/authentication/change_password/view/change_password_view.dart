import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/input_text_decoration.dart';
import '../viewmodel/change_password_view_model.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ChangePasswordViewModel>(
      viewModel: ChangePasswordViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, ChangePasswordViewModel viewmodel) => buildScaffold(context, viewmodel),
    );
  }

  Widget buildScaffold(BuildContext context, ChangePasswordViewModel viewmodel) => Scaffold(
        key: viewmodel.scaffoldState,
        appBar: AppBar(),
        body: Observer(
          builder: (_) {
            return Center(
              child: Form(
                key: viewmodel.formState,
                child: FormColumn(
                  children: [
                    buildWelcomeTextColumnBuild(context),
                    context.emptySizedHeightBoxNormal,
                    buildCurrentPasswordTextField(viewmodel, context),
                    context.emptySizedHeightBoxLow,
                    buildFirstPasswordTextField(viewmodel, context),
                    context.emptySizedHeightBoxLow,
                    buildLaterPasswordTextField(viewmodel, context),
                    context.emptySizedHeightBoxLow,
                    buildChangePasswordButton(viewmodel, context),
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget buildWelcomeTextColumnBuild(BuildContext context) {
    return Text(
      LocaleKeys.updatePasswordText.locale,
      style: context.textTheme.headline5!.copyWith(color: context.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold),
    );
  }

  Widget buildCurrentPasswordTextField(ChangePasswordViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.theFieldRequiredText.locale,
        controller: viewModel.currentPasswordController,
        obscureText: viewModel.isCurrentLockOpen,
        decoration: buildInputDecoration(context,
            hintText: LocaleKeys.enterCurrentPasswordText.locale,
            prefixIcon: Icons.vpn_key,
            suffixIcon: TextButton(
              onPressed: () {
                viewModel.isCurrentLockOpenchange();
              },
              child: Observer(builder: (_) {
                return Icon(viewModel.isCurrentLockOpen ? Icons.lock : Icons.lock_open);
              }),
            ),
            prefixIconColor: context.colorScheme.primary),
      );
    });
  }

  Widget buildFirstPasswordTextField(ChangePasswordViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        validator: (value) => value!.isNotEmpty ? null : LocaleKeys.theFieldRequiredText.locale,
        controller: viewModel.newFirstPasswordController,
        obscureText: viewModel.isFirstLockOpen,
        decoration: buildInputDecoration(context,
            hintText: LocaleKeys.enterPasswordText.locale,
            prefixIcon: Icons.vpn_key,
            suffixIcon: TextButton(
              onPressed: () {
                viewModel.isFirstLockStateChange();
              },
              child: Observer(builder: (_) {
                return Icon(viewModel.isFirstLockOpen ? Icons.lock : Icons.lock_open);
              }),
            ),
            prefixIconColor: context.colorScheme.primary),
      );
    });
  }

  Widget buildLaterPasswordTextField(ChangePasswordViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        validator: (value) => value!.isEmpty
            ? LocaleKeys.theFieldRequiredText.locale
            : viewModel.newSecondPasswordController!.text != viewModel.newFirstPasswordController!.text
                ? LocaleKeys.passwordNotSameText.locale
                : null,
        controller: viewModel.newSecondPasswordController,
        obscureText: viewModel.isLaterLockOpen,
        decoration: buildInputDecoration(context,
            hintText: LocaleKeys.againPasswordText.locale,
            prefixIcon: Icons.vpn_key,
            suffixIcon: TextButton(
              onPressed: () {
                viewModel.isLaterLockStateChange();
              },
              child: Observer(builder: (_) {
                return Icon(viewModel.isLaterLockOpen ? Icons.lock : Icons.lock_open);
              }),
            ),
            prefixIconColor: context.colorScheme.primary),
      );
    });
  }

  Widget buildChangePasswordButton(ChangePasswordViewModel viewModel, BuildContext context) {
    return Center(
      child: Observer(builder: (_) {
        return viewModel.isLoading
            ? CallCircularProgress(context)
            : NormalButton(
                child: Text(
                  LocaleKeys.updatePasswordText.locale,
                  style: context.textTheme.headline6!.copyWith(color: context.colorScheme.inversePrimary),
                ),
                onPressed: () {
                  viewModel.updataPassword();
                },
                color: context.appTheme.colorScheme.onSurfaceVariant,
              );
      }),
    );
  }
}
