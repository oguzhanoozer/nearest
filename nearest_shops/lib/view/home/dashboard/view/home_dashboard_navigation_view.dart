import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../product/bottom_navigation/bottom_user _navigation.dart';
import '../../categories/view/categories_view.dart';
import '../../owner_product_list/view/owner_product_list_view.dart';
import '../../shop_list/model/shop_model.dart';
import '../../shop_list/view/shop_list_view.dart';
import '../../user_favourite_list/view/user_favourite_list_view.dart';
import '../../user_profile/view/user_profile_view.dart';
import 'dashboard_view.dart';

class HomeDashboardNavigationView extends StatefulWidget {
  final bool isDirection;
  final ShopModel? shopModel;
  HomeDashboardNavigationView(
      {Key? key, this.isDirection = false, this.shopModel})
      : super(key: key);

  @override
  State<HomeDashboardNavigationView> createState() =>
      _HomeDashboardNavigationViewState();
}

class _HomeDashboardNavigationViewState
    extends State<HomeDashboardNavigationView> {
  late final List<Widget> _widgetList;

  late int _currentWidgetIndex;

  @override
  void initState() {
    super.initState();
    _currentWidgetIndex = widget.isDirection ? 2 : 0;
    _widgetList = [
      DashboardView(),
      CategoriesView(),
      widget.isDirection
          ? OwnerProductListMapView(
              isDirection: true, shopModel: widget.shopModel)
          : OwnerProductListMapView(),
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
        items: BottomUserNavigatorDashboardListModel().modelToBarItemWidgets(),
      ),
    );
  }

  void changePage(int index) {
    setState(() {
      _currentWidgetIndex = index;
    });
  }
}
