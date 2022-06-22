import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/lang/language_manager.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../../core/init/theme/app_theme.dart';
import '../../../authentication/onboard/view/onboard_view.dart';

part 'shop_owner_settings_view_model.g.dart';

class ShopOwnerSettingsViewModel = _ShopOwnerSettingsViewModelBase with _$ShopOwnerSettingsViewModel;

abstract class _ShopOwnerSettingsViewModelBase with Store, BaseViewModel {
  late Locale appLocale;
  late String currentLangTitle;

  @observable
  bool isLogOut = false;

  @action
  void changeIsLogOut() {
    isLogOut = !isLogOut;
  }

  @override
  void init() {}

  Future<void> changeAppTheme() async {
    if (this.context != null) {
      context!.read<ThemeManager>().changeTheme();
    }
  }

  Future<void> logOut() async {
    changeIsLogOut();
    await FirebaseAuthentication.instance.signOut();
    Navigator.pushReplacementNamed(context!, onBoardViewRoute);
    changeIsLogOut();
  }

  @override
  setContext(BuildContext context) {
    this.context = context;

    changerLangSetting(context.locale);
  }

  void changerLangSetting(Locale locale) {
    appLocale = locale;
    currentLangTitle = LanguageManager.instance.getLanguageTitle(appLocale);
  }

  @action
  void changeAppLanguage(Locale? locale) {
    if (locale != null) {
      appLocale = locale;
      changerLangSetting(appLocale);
      context!.setLocale(locale);
    }
  }
}
