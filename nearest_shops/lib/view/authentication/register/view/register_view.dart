import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/button_shadow.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/button/text_button.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/input_text_decoration.dart';
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

  Scaffold buildScaffold(BuildContext context, RegisterViewModel viewModel) => Scaffold(
      key: viewModel.scaffoldState,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(child: buildLoginForm(context, viewModel)),
          ),
        ],
      ));

  Widget buildLoginForm(BuildContext context, RegisterViewModel viewModel) {
    return Form(
      key: viewModel.formState,
      child: buildFormColumn(viewModel, context),
    );
  }

  Widget buildFormColumn(RegisterViewModel viewModel, BuildContext context) {
    return FormColumn(
      children: [
        context.emptySizedHeightBoxLow,
        SizedBox(
          height: context.dynamicHeight(0.3),
          width: context.dynamicWidth(0.9),
          child: Lottie.asset(
            ImagePaths.instance.loti_17,
            repeat: true,
            reverse: true,
            animate: true,
          ),
        ),
        context.emptySizedHeightBoxNormal,
        buildWelcomeTextColumnBuild(context),
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
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            LocaleKeys.createAccountText.locale,
            style: context.textTheme.headline5!.copyWith(color: context.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold),
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

  Widget buildRegisterButton(BuildContext context, RegisterViewModel viewModel) {
    return Observer(builder: (_) {
      return viewModel.isLoading
          ? CallCircularProgress(context)
          : ButtonShadow(
              onTap: () async {
                await viewModel.checkUserData();
              },
              child: Text(
                LocaleKeys.registerButtonText.locale,
                style: GoogleFonts.lora(
                    textStyle: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.onSurfaceVariant)),
              ),
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
