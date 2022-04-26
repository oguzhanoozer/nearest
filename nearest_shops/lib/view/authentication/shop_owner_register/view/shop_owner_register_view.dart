import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/extension/string_extension.dart';
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
          //appBar: AppBar(),
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
        context.emptySizedHeightBoxLow3x,
        buildWelcomeTextColumnBuild(context),
        context.emptySizedHeightBoxLow3x,
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
        context.emptySizedHeightBoxLow,
        buildRegisterButton(context, viewModel),
      ],
    );
  }
 
  

  Widget buildWelcomeTextColumnBuild(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Text(
        LocaleKeys.welcomeBusinessText.locale,
        style: context.textTheme.headline6!.copyWith(
            color: context.colorScheme.onPrimary, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildRegisterButton(
      BuildContext context, ShopOwnerRegisterViewModel viewModel) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
          LocaleKeys.createBusinessAccountButtonText.locale,
          style: context.textTheme.headline6!
              .copyWith(color: context.colorScheme.onSecondary),
        ),
        onPressed: viewModel.isLoading
            ? null
            : () async {
                await viewModel.registerOwnerData(context);
              },
        color: context.appTheme.colorScheme.onSurfaceVariant,
      );
    });
  }
}
