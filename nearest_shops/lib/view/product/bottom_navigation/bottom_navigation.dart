import 'package:flutter/material.dart';

class BottomNavigatorModel {
  final IconData icon;
  final String title;

  BottomNavigatorModel(this.icon, this.title);
}

class BottomNavigatorDashboardListModel {
  late final List<BottomNavigatorModel> _navigatorModelItems;
  BottomNavigatorDashboardListModel() {
    _navigatorModelItems = [
      BottomNavigatorModel(Icons.home, "Home"),
      BottomNavigatorModel(Icons.location_on, "Shops Map"),
      BottomNavigatorModel(Icons.shopping_cart_checkout_sharp, "Shops List"),
      BottomNavigatorModel(Icons.favorite_outline_sharp, "Favorite"),
    ];
  }

  List<BottomNavigationBarItem> modelToBarItemWidgets() {
    return _navigatorModelItems
        .map((e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.title))
        .toList();
  }
}
