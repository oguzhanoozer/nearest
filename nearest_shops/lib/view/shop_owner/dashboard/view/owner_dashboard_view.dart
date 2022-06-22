import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';

import '../../../../core/base/model/add_product_view_arg.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../ads/banner/add_banner_view.dart';
import '../../../product/bottom_navigation/bottom_owner_dashboard.dart';
import '../../add_product/view/add_product_view.dart';
import '../../home/view/owner_home_view.dart';
import '../../settings/view/shop_owner_settings_view.dart';
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
      OwnerHomeView(),
      ShopOwnerProductListView(),
      AddProductView(addProductViewArguments: AddProductViewArguments(null, isUpdate: false)),
      ShopOwnerSettingsView()
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
      onPageBuilder: (context, OwnerDashboardViewModel value) => buildScaffold(),
    );
  }

  Widget buildScaffold() => Column(
        children: [
          Expanded(
            child: Scaffold(
              body: _widgetList[_currentWidgetIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentWidgetIndex,
                selectedItemColor: context.appTheme.colorScheme.onSurfaceVariant,
                onTap: ((value) => changePage(value)),
                elevation: 0,
                items: BottomOwnerNavigatorDashboardListModel().modelToOwnerBarItemWidgets(),
              ),
            ),
          ),
          AddBannerView(),
        ],
      );
  void changePage(int index) {
    setState(() {
      _currentWidgetIndex = index;
    });
  }
}
