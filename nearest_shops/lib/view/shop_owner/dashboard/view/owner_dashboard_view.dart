import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/shop_owner/add_product/view/add_product_view.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../home/owner_product_list/view/map_shop_view.dart';
import '../../add_product/viewmodel/add_product_view_model.dart';
import '../../home/view/map_shop_view.dart';
import '../../home/view/owner_home_view.dart';
import '../../shop_owner_product_list/view/shop_owner_product_list_view.dart';
import '../viewmodel/owner_dashboard_view_model.dart';

class OwnerDashboardView extends StatefulWidget {
  OwnerDashboardView({Key? key}) : super(key: key);

  @override
  State<OwnerDashboardView> createState() => _OwnerDashboardViewState();
}

class _OwnerDashboardViewState extends State<OwnerDashboardView> {

  late final List<Widget> _widgetList;

  int _currentWidgetIndex = 0;

  @override
  void initState() {
    super.initState();
    _widgetList = [
      MapShowView(),
      ShopOwnerProductListView(),
      AddProductView(
        
          )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<OwnerDashboardViewModel>(
      viewModel: OwnerDashboardViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, OwnerDashboardViewModel value) =>
          buildScaffold(),
    );
  }

  Scaffold buildScaffold() => Scaffold(
        body: _widgetList[_currentWidgetIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: context.appTheme.colorScheme.onSurfaceVariant,
          onTap: ((value) => changePage(value)),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.line_style),
              label: "Products",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: "Product Add"),
          ],
        ),
      );
  void changePage(int index) {
    setState(() {
      _currentWidgetIndex = index;
    });
  }
}
