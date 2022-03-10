import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/icon_button.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/button/text_button.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/contstants/image_path_svg.dart';
import '../../onboard/view/on_board_option_view.dart';
import '../../onboard/view/onboard_view.dart';
import '../../register/view/register_view.dart';
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

  Scaffold buildScaffold(BuildContext context, LoginViewModel viewModel) =>
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

  Container buildLoginForm(BuildContext context, LoginViewModel viewModel) {
    return Container(
      child: Form(
        key: viewModel.formState,
        child: buildFormColumn(viewModel, context),
      ),
    );
  }

  Widget buildFormColumn(LoginViewModel viewModel, BuildContext context) {
    return FormColumn(
      children: [
        context.emptySizedHeightBoxNormal,
        buildWelcomeTextColumnBuild(context),
        context.emptySizedHeightBoxHigh,
        buildEmailTextField(viewModel, context),
        context.emptySizedHeightBoxLow,
        buildPasswordTextField(viewModel, context),
        buildForgotPasswordText(),
        context.emptySizedHeightBoxNormal,
        buildLoginButton(context, viewModel),
        buildCreateAccountButton(context),
        context.emptySizedHeightBoxLow,
        buildSocialMediaIcons(context, viewModel),
      ],
    );
  }

  Row buildSocialMediaIcons(BuildContext context, LoginViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /*
        SizedBox(
          height: context.mediumValue,
          width: context.mediumValue,
          child: ClipOval(
            child: SvgPicture.asset(SVGIMagePaths.instance.facebookSVG),
          ),
        ),
        */

        NormalIconButton(
          onPressed: () {},
          icon: ClipOval(
            child: SvgPicture.asset(SVGIMagePaths.instance.facebookSVG),
          ),
        ),
        NormalIconButton(
          onPressed: () async {
            await viewModel.signWithGoogle();
          },
          icon: ClipOval(
            child: SvgPicture.asset(SVGIMagePaths.instance.googleSVG),
          ),
        ),
      ],
    );
  }

  Widget buildWelcomeText(BuildContext context) {
    return buildWelcomeTextColumnBuild(context);
  }

  Widget buildWelcomeTextColumnBuild(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            LocaleKeys.login.locale,
            style: context.textTheme.headline2!
                .copyWith(color: context.colorScheme.onPrimary),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            LocaleKeys.welcomeBack.locale,
            style: context.textTheme.headline5!
                .copyWith(color: context.colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }

  NormalTextButton buildCreateAccountButton(BuildContext context) {
    return NormalTextButton(
      text: LocaleKeys.createAccount.locale,
      onPressed: () {
        context.navigateToPage(OnBoardOptionView());
      },
    );
  }

  Widget buildLoginButton(BuildContext context, LoginViewModel viewModel) {
    return Observer(builder: (_) {
      return NormalButton(
        child: Text(
          LocaleKeys.loginButtonText.locale,
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

  Align buildForgotPasswordText() {
    return Align(
      alignment: Alignment.centerRight,
      child: NormalTextButton(
          text: LocaleKeys.forgotPassword.locale, onPressed: () {}),
    );
  }
}
