import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/base/route/generate_route.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/button_shadow.dart';
import '../../../../core/components/button/text_button.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/contstants/image_path_svg.dart';
import '../../../product/input_text_decoration.dart';
import '../../onboard/view/on_board_option_view.dart';
import '../../reset_password/view/reset_password_view.dart';
import '../viewmodel/login_view_model.dart';

part 'subview/login_view_textfields.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        viewModel: LoginViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, LoginViewModel viewModel) {
          return buildScaffold(context, viewModel);
        });
  }

  Scaffold buildScaffold(BuildContext context, LoginViewModel viewModel) => Scaffold(
      key: viewModel.scaffoldState,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: buildLoginForm(context, viewModel),
          ),
        ],
      ));

  Widget buildLoginForm(BuildContext context, LoginViewModel viewModel) {
    return Form(
      key: viewModel.formState,
      child: buildFormColumn(viewModel, context),
    );
  }

  Widget buildFormColumn(LoginViewModel viewModel, BuildContext context) {
    return FormColumn(
      children: [
        context.emptySizedHeightBoxLow,
        buildWelcomeTextColumnBuild(context),
        context.emptySizedHeightBoxLow3x,
        buildEmailTextField(viewModel, context),
        context.emptySizedHeightBoxLow,
        buildPasswordTextField(viewModel, context),
        buildForgotPasswordText(context),
        context.emptySizedHeightBoxLow3x,
        buildLoginButton(context, viewModel),
        buildCreateAccountButton(context),
        context.emptySizedHeightBoxLow,
        buildSocialMediaIcons(context, viewModel),
        context.emptySizedHeightBoxHigh,
      ],
    );
  }

  Widget buildSocialMediaIcons(BuildContext context, LoginViewModel viewModel) {
    return ButtonShadow(
      onTap: () async {
        await viewModel.signWithGoogle();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ContentString.GOOGLE.rawValue,
            style: GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.onSurfaceVariant)),
          ),
          context.emptySizedWidthBoxLow3x,
          Padding(
            padding: context.paddingLow,
            child: SvgPicture.asset(
              SVGIMagePaths.instance.googleSVG,
              width: context.dynamicHeight(0.05),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWelcomeText(BuildContext context) {
    return buildWelcomeTextColumnBuild(context);
  }

  Widget buildWelcomeTextColumnBuild(BuildContext context) {
    return Expanded(
      child: Lottie.asset(
        ImagePaths.instance.loti_16,
        repeat: true,
        reverse: true,
        animate: true,
      ),
    );
  }

  Widget buildCreateAccountButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(LocaleKeys.donthaveaAccount.locale,
            maxLines: 3,
            style: GoogleFonts.lora(textStyle: context.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w500, color: context.colorScheme.primary))),
        NormalTextButton(
          text: LocaleKeys.createAccountText.locale,
          onPressed: () {
            Navigator.pushNamed(context, onBoardOptionViewRoute);
          },
        ),
      ],
    );
  }

  Widget buildLoginButton(BuildContext context, LoginViewModel viewModel) {
    return Observer(builder: (_) {
      return viewModel.isLoading
          ? CallCircularProgress(context)
          : ButtonShadow(
              onTap: () async {
                await viewModel.checkUserData();
              },
              child: Text(
                LocaleKeys.loginButtonText.locale,
                style: GoogleFonts.lora(
                    textStyle: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.onSurfaceVariant)),
              ),
            );
    });
  }

  Align buildForgotPasswordText(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: NormalTextButton(
        text: LocaleKeys.forgotPasswordText.locale,
        onPressed: () {
          Navigator.pushNamed(context, resetPasswordViewRoute);
        },
      ),
    );
  }
}
