import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/button_shadow.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/input_text_decoration.dart';
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
      onPageBuilder: (BuildContext context, ShopOwnerRegisterViewModel viewModel) {
        return buildScaffold(context, viewModel);
      },
    );
  }

  Scaffold buildScaffold(BuildContext context, ShopOwnerRegisterViewModel viewModel) => Scaffold(
      //appBar: AppBar(),
      key: viewModel.scaffoldState,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(child: buildLoginForm(context, viewModel)),
          ),
        ],
      ));

  Widget buildLoginForm(BuildContext context, ShopOwnerRegisterViewModel viewModel) {
    return Form(
      key: viewModel.formState,
      child: buildFormColumn(viewModel, context),
    );
  }

  Widget buildFormColumn(ShopOwnerRegisterViewModel viewModel, BuildContext context) {
    return FormColumn(
      children: [
        context.emptySizedHeightBoxLow,
        SizedBox(
          height: context.dynamicHeight(0.25),
          width: context.dynamicWidth(0.9),
          child: Lottie.asset(
            ImagePaths.instance.loti_8,
            repeat: true,
            reverse: true,
            animate: true,
          ),
        ),
        context.emptySizedHeightBoxLow,
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
        context.emptySizedHeightBoxLow3x,
        buildRegisterButton(context, viewModel),
        context.emptySizedHeightBoxLow3x,
      ],
    );
  }

  Widget buildWelcomeTextColumnBuild(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Text(
        LocaleKeys.createBusinessAccountButtonText.locale,
        style: context.textTheme.headline5!.copyWith(color: context.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildRegisterButton(BuildContext context, ShopOwnerRegisterViewModel viewModel) {
    return Observer(builder: (_) {
      return viewModel.isLoading
          ? CallCircularProgress(context)
          : ButtonShadow(
              onTap: () async {
                await viewModel.registerOwnerData(context);
              },
              child: Text(
                LocaleKeys.createBusinessAccountButtonText.locale,
                style: GoogleFonts.lora(
                    textStyle: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.onSurfaceVariant)),
              ),
            );
    });
  }
}
