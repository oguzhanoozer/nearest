import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/button_shadow.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/input_text_decoration.dart';
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
        onPageBuilder: (BuildContext context, ResetPasswordViewModel viewModel) {
          return buildScaffold(context, viewModel);
        });
  }

  Widget buildScaffold(BuildContext context, ResetPasswordViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(),
      key: viewModel.scaffoldState,
      body: Center(
        child: FormColumn(children: [
          Text(
            LocaleKeys.createAccountText.locale,
            style: context.textTheme.headline5!.copyWith(color: context.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold),
          ),
          context.emptySizedHeightBoxNormal,
          SingleChildScrollView(
            child: Form(
              key: viewModel.formState,
              child: buildResetEmailTextField(viewModel, context),
            ),
          ),
          context.emptySizedHeightBoxNormal,
          buildResetEmailButton(viewModel, context),
        ]),
      ),
    );
  }

  TextFormField buildResetEmailTextField(ResetPasswordViewModel viewModel, BuildContext context) {
    return TextFormField(
        style: inputTextStyle(context),
        validator: (value) => value!.isValidEmail ? null : LocaleKeys.enterValidEmailText.locale,
        keyboardType: TextInputType.emailAddress,
        controller: viewModel.emailResetTextController,
        decoration:
            buildInputDecoration(context, hintText: LocaleKeys.emailExampleText.locale, prefixIcon: Icons.email, prefixIconColor: context.colorScheme.primary)


        );
  }

  Widget buildResetEmailButton(ResetPasswordViewModel viewModel, BuildContext context) {
    return Observer(
      builder: (_) {
        return viewModel.isResetEmailSend
            ? CallCircularProgress(context)
            : ButtonShadow(
                onTap: () async {
                  if (!viewModel.isResetEmailSend) {
                    await viewModel.sendResetPasswordEmail();
                  }
                },
                child: Text(
                  LocaleKeys.resetText.locale,
                  style: GoogleFonts.lora(
                      textStyle: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.onSurfaceVariant)),
                ),
              );
      },
    );
  }
}
