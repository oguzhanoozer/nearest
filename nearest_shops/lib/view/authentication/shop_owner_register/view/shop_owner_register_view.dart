import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/extension/string_extension.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../viewmodel/shop_owner_login_view_model.dart';

part 'subview/owner_register_extension.dart';

class ShopOwnerRegisterView extends StatelessWidget {
  const ShopOwnerRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ShopOwnerRegisterViewModel>(
      viewModel: ShopOwnerRegisterViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, ShopOwnerRegisterViewModel viewModel) {
        return buildScaffold(context, viewModel);
      },
    );
  }

  Scaffold buildScaffold(
          BuildContext context, ShopOwnerRegisterViewModel viewModel) =>
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

  Container buildLoginForm(
      BuildContext context, ShopOwnerRegisterViewModel viewModel) {
    return Container(
      child: Form(
        key: viewModel.formState,
        child: buildFormColumn(viewModel, context),
      ),
    );
  }

  Widget buildFormColumn(
      ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return FormColumn(
      children: [
        context.emptySizedHeightBoxHigh,
        buildWelcomeTextColumnBuild(context),
        context.emptySizedHeightBoxLow,
        buildNameTextField(viewModel, context),
        context.emptySizedHeightBoxLow,
        buildAdressTextField(viewModel, context),
        context.emptySizedHeightBoxLow,
        buildPhoneTextField(viewModel, context),
        context.emptySizedHeightBoxLow,
        buildEmailTextField(viewModel, context),
        context.emptySizedHeightBoxLow,
        buildFirstPasswordTextField(viewModel, context),
        context.emptySizedHeightBoxLow,
        buildLaterPasswordTextField(viewModel, context),
        context.emptySizedHeightBoxHigh,
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
            "Welcome to business",
            style: context.textTheme.headline5!
                .copyWith(color: context.colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }

  Widget buildRegisterButton(
      BuildContext context, ShopOwnerRegisterViewModel viewModel) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
          LocaleKeys.createAccount.locale,
          style: context.textTheme.headline6!
              .copyWith(color: context.colorScheme.onSecondary),
        ),
        onPressed: viewModel.isLoading ? null : () async {},
        color: context.appTheme.colorScheme.onSurfaceVariant,
      );
    });
  }
}
