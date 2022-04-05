import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../owner_product_list/view/owner_product_list_view.dart';
import '../../shop_list/view/shop_list_view.dart';
import '../../user_favourite_list/view/user_favourite_list_view.dart';
import 'dashboard_view.dart';

class HomeDashboardNavigationView extends StatefulWidget {
  HomeDashboardNavigationView({Key? key}) : super(key: key);

  @override
  State<HomeDashboardNavigationView> createState() =>
      _HomeDashboardNavigationViewState();
}

class _HomeDashboardNavigationViewState
    extends State<HomeDashboardNavigationView> {
  late final List<Widget> _widgetList;

  int _currentWidgetIndex = 0;

  @override
  void initState() {
    super.initState();
    _widgetList = [
      DashboardView(),

      ///ShopListView(),
      OwnerUserProductListView(),
      ShopListView(),
      UserFavouriteProductListView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetList[_currentWidgetIndex],
      bottomNavigationBar: BottomNavigationBar(
        /// fixedColor: context.appTheme.colorScheme.onSurfaceVariant,
        selectedItemColor: context.appTheme.colorScheme.onSurfaceVariant,
        currentIndex: _currentWidgetIndex,

        onTap: ((value) => changePage(value)),
        elevation: 0,
        // ignore: prefer_const_literals_to_create_immutables
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "Shops Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout_sharp),
            label: "Shops List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_sharp),
            label: "Favorite",
          ),
        ],
      ),
    );
  }

  void changePage(int index) {
    setState(() {
      _currentWidgetIndex = index;
    });
  }
}
