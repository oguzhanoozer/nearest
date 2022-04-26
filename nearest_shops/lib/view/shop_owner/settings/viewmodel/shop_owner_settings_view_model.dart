import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/lang/language_manager.dart';
import '../../../../core/init/theme/app_theme.dart';

part 'shop_owner_settings_view_model.g.dart';

class ShopOwnerSettingsViewModel = _ShopOwnerSettingsViewModelBase with _$ShopOwnerSettingsViewModel;

abstract class _ShopOwnerSettingsViewModelBase with Store ,BaseViewModel{
  

  late AppThemeMode currentAppThemeMode;
  late Locale appLocale;
  late String currentLangTitle;
  


  void init() {}



 void changeAppTheme() {
    if (this.context != null) {
      context!.read<ThemeManager>().changeTheme();
      currentAppThemeMode = context!.read<ThemeManager>().currentThemeMode;
    }
  }


  @override
  setContext(BuildContext context) {
    this.context = context;
    
    currentAppThemeMode = context.read<ThemeManager>().currentThemeMode;
    changerLangSetting(context.locale);

    ///appLocale = context.locale;
    ///currentLangTitle = LanguageManager.instance.getLanguageTitle(appLocale);
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

      ///currentLangTitle = LanguageManager.instance.getLanguageTitle(appLocale);
    }
  }
}