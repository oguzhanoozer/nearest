import 'package:flutter/material.dart';

import '../../../core/extension/string_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';

class BottomNavigatorModel {
  final IconData icon;
  final String title;

  BottomNavigatorModel(this.icon, this.title);
}

class BottomUserNavigatorDashboardListModel {
  late final List<BottomNavigatorModel> _navigatorModelItems;
  BottomUserNavigatorDashboardListModel() {
    _navigatorModelItems = [
      BottomNavigatorModel(Icons.home, LocaleKeys.bottomHomeText.locale),
      BottomNavigatorModel(Icons.category, LocaleKeys.bottomCategoriesText.locale),
      BottomNavigatorModel(Icons.location_on, LocaleKeys.bottomShopMapText.locale),
      BottomNavigatorModel(Icons.shopping_cart_checkout_sharp, LocaleKeys.bottomShopListText.locale),
      BottomNavigatorModel(Icons.favorite_rounded, LocaleKeys.bottomFavouriteText.locale),
    ];
  }

  List<BottomNavigationBarItem> modelToBarItemWidgets() {
    return _navigatorModelItems.map((e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.title)).toList();
  }
}
