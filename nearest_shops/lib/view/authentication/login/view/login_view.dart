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

  Scaffold buildScaffold(BuildContext context, LoginViewModel viewModel) =>
      Scaffold(
          key: viewModel.scaffoldState,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: buildLoginForm(context, viewModel),
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
        context.emptySizedHeightBoxLow,
        buildWelcomeTextColumnBuild(context),
        context.emptySizedHeightBoxLow,
        buildEmailTextField(viewModel, context),
        context.emptySizedHeightBoxLow,
        buildPasswordTextField(viewModel, context),
        buildForgotPasswordText(context),
        context.emptySizedHeightBoxLow,
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
        Container(
            //height: 300,
            //width: 300,
            child: CircleAvatar(
          radius: 150,
          backgroundColor: context.colorScheme.onSecondary,
          child: Image.asset(
            "asset/image/shop_orange.png",
            fit: BoxFit.fill,
          ),
        )),
   
      ],
    );
  }

  NormalTextButton buildCreateAccountButton(BuildContext context) {
    return NormalTextButton(
      text: LocaleKeys.createAccountText.locale,
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

  Align buildForgotPasswordText(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: NormalTextButton(
          text: LocaleKeys.forgotPasswordText.locale,
          onPressed: () {
            context.navigateToPage(ResetPasswordView());
          }),
    );
  }
}
