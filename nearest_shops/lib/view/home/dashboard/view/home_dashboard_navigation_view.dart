import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/model/home_dashboard_navigation_arg.dart';
import '../../../ads/banner/add_banner_view.dart';
import '../../../product/bottom_navigation/bottom_user _navigation.dart';
import '../../categories/view/categories_view.dart';
import '../../owner_product_list/view/owner_product_list_view.dart';
import '../../shop_list/model/shop_model.dart';
import '../../shop_list/view/shop_list_view.dart';
import '../../user_favourite_list/view/user_favourite_list_view.dart';
import 'dashboard_view.dart';

class HomeDashboardNavigationView extends StatefulWidget {
  HomeDashboardNavigationArg homeDashboardNavigationArg;
  HomeDashboardNavigationView({Key? key,required this.homeDashboardNavigationArg}) : super(key: key);

  @override
  State<HomeDashboardNavigationView> createState() => _HomeDashboardNavigationViewState();
}

class _HomeDashboardNavigationViewState extends State<HomeDashboardNavigationView> {
  late final List<Widget> _widgetList;

  late int _currentWidgetIndex;

  @override
  void initState() {
    super.initState();
    _currentWidgetIndex = widget.homeDashboardNavigationArg.isDirection ? 2 : 0;
    _widgetList = [
      DashboardView(),
      const CategoriesView(),
      widget.homeDashboardNavigationArg.isDirection ? OwnerProductListMapView(isDirection: true, shopModel: widget.homeDashboardNavigationArg.shopModel) : OwnerProductListMapView(),
      ShopListView(),
      UserFavouriteProductListView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: _widgetList[_currentWidgetIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: context.appTheme.colorScheme.onSurfaceVariant,
              currentIndex: _currentWidgetIndex,
              onTap: ((value) => changePage(value)),
              elevation: 0,
              items: BottomUserNavigatorDashboardListModel().modelToBarItemWidgets(),
            ),
          ),
        ),
        const AddBannerView(),
      ],
    );
  }

  void changePage(int index) {
    setState(() {
      _currentWidgetIndex = index;
    });
  }
}
