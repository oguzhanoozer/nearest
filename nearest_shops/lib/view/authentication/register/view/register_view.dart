import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/button/text_button.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../viewmodel/register_view_model.dart';

part 'subview/register_view_textfields.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
        viewModel: RegisterViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, RegisterViewModel viewModel) {
          return buildScaffold(context, viewModel);
        });
  }

  Scaffold buildScaffold(BuildContext context, RegisterViewModel viewModel) =>
      Scaffold(
          key: viewModel.scaffoldState,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: buildLoginForm(context, viewModel)),
              ),
            ],
          ));

  Container buildLoginForm(BuildContext context, RegisterViewModel viewModel) {
    return Container(
      child: Form(
        key: viewModel.formState,
        child: buildFormColumn(viewModel, context),
      ),
    );
  }

  Widget buildFormColumn(RegisterViewModel viewModel, BuildContext context) {
    return FormColumn(
      children: [
        context.emptySizedHeightBoxHigh,
        buildWelcomeTextColumnBuild(context),
        context.emptySizedHeightBoxNormal,
        buildEmailTextField(viewModel, context),
        context.emptySizedHeightBoxNormal,
        buildFirstPasswordTextField(viewModel, context),
        context.emptySizedHeightBoxNormal,
        buildLaterPasswordTextField(viewModel, context),
        context.emptySizedHeightBoxNormal,
        buildRegisterButton(context, viewModel),
      ],
    );
  }

  Widget buildWelcomeTextColumnBuild(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            LocaleKeys.createAccountText.locale,
            style: context.textTheme.headline4!
                .copyWith(color: context.colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }

  NormalTextButton buildCreateAccountButton() {
    return NormalTextButton(
      text: LocaleKeys.createAccountText.locale,
      onPressed: () {},
    );
  }

  Widget buildRegisterButton(
      BuildContext context, RegisterViewModel viewModel) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
          LocaleKeys.createAccountText.locale,
          style: context.textTheme.headline6!
              .copyWith(color: context.colorScheme.onSecondary),
        ),
        onPressed: viewModel.isLoading
            ? null
            : () async {
                await viewModel.checkUserData();
              },
        color: context.appTheme.colorScheme.onSurfaceVariant,
      );
    });
  }

  Container buildContainerIconField(BuildContext context, IconData icon) {
    return Container(
      padding: context.paddingLow,
      child: Icon(icon, color: context.appTheme.colorScheme.onSurfaceVariant),
    );
  }
}
