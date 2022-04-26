import 'package:flutter/material.dart';

import '../../../core/extension/string_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import 'bottom_user _navigation.dart';

class BottomOwnerNavigatorDashboardListModel {
  late final List<BottomNavigatorModel> _navigatorModelItems;
  BottomOwnerNavigatorDashboardListModel() {
    _navigatorModelItems = [
      BottomNavigatorModel(Icons.home,  LocaleKeys.bottomHomeText.locale),
      BottomNavigatorModel(Icons.line_style, LocaleKeys.bottomProductsText.locale),
      BottomNavigatorModel(Icons.add_shopping_cart, LocaleKeys.bottomProductAddText.locale),
      BottomNavigatorModel(Icons.person, LocaleKeys.bottomProfileText.locale),
    ];
  }

  List<BottomNavigationBarItem> modelToOwnerBarItemWidgets() {
    return _navigatorModelItems
        .map((e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.title))
        .toList();
  }
}
