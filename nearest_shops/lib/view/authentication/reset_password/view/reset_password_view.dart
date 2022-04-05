import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/base/view/base_view.dart';

import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/column/form_column.dart';
import '../viewmodel/reset_password_view_model.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ResetPasswordViewModel>(
        viewModel: ResetPasswordViewModel(),
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onPageBuilder:
            (BuildContext context, ResetPasswordViewModel viewModel) {
          return buildScaffold(context, viewModel);
        });
  }

  Widget buildScaffold(BuildContext context, ResetPasswordViewModel viewModel) {
    return Scaffold(
      key: viewModel.scaffoldState,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Reset Your Password",
            style: context.textTheme.headline6!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          context.emptySizedHeightBoxNormal,
          SingleChildScrollView(
            child: Form(
              key: viewModel.formState,
              child: FormColumn(
                children: [
                  buildResetEmailTextField(viewModel, context),
                ],
              ),
            ),
          ),
          context.emptySizedHeightBoxNormal,
          buildResetEmailButton(viewModel, context),
        ]),
      ),
    );
  }

  TextFormField buildResetEmailTextField(
      ResetPasswordViewModel viewModel, BuildContext context) {
    return TextFormField(
      validator: (value) =>
          value!.isValidEmail ? null : "Enter valid email address",
      keyboardType: TextInputType.emailAddress,
      controller: viewModel.emailResetTextController,
      decoration: buildResetEmailTextFieldDecoration(context),
    );
  }

  InputDecoration buildResetEmailTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelStyle: context.textTheme.subtitle1,
        label: Text("Email address"),
        icon: Container(
          padding: context.paddingLow,
          child: Icon(Icons.email,
              color: context.appTheme.colorScheme.onSurfaceVariant),
        ),
        hintText: "Email address");
  }

  Widget buildResetEmailButton(
      ResetPasswordViewModel viewModel, BuildContext context) {
    return Observer(
      builder: (_) {
        return viewModel.isResetEmailSend
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : NormalButton(
                child: Text(
                  "Reset",
                  style: context.textTheme.headline6!
                      .copyWith(color: context.colorScheme.onSecondary),
                ),
                onPressed: viewModel.isResetEmailSend
                    ? null
                    : () async {
                        await viewModel.sendResetPasswordEmail();
                      },
                color: context.appTheme.colorScheme.onSurfaceVariant,
              );
      },
    );
  }
}
