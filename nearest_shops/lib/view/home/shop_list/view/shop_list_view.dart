import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/product_list_view/product_list_view.dart';
import '../../dashboard/view/home_dashboard_navigation_view.dart';
import '../model/shop_model.dart';
import '../viewmodel/shop_list_view_model.dart';

class ShopListView extends StatelessWidget {
  const ShopListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ShopListViewModel>(
      viewModel: ShopListViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, ShopListViewModel viewmodel) =>
          buildScaffold(context, viewmodel),
    );
  }

  Widget buildScaffold(
    BuildContext context,
    ShopListViewModel viewmodel,
  ) {
    return SafeArea(
      child: Scaffold(
          key: viewmodel.scaffoldState,
          appBar: buildAppBar(context, viewmodel),
          body: Observer(builder: (_) {
            return viewmodel.isShopMapListLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : buildShopList(viewmodel, context);
          })),
    );
  }

  Widget buildShopList(ShopListViewModel viewmodel, BuildContext context) {
    List<ShopModel> currentShopList = viewmodel.shopModelList;

    return Padding(
      padding: context.paddingNormal,
      child: ListView.builder(
        itemCount: currentShopList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.paddingLow,
            child: buildShopCard(context, currentShopList[index], index),
          );
        },
      ),
    );
  }

  Widget buildShopCard(BuildContext context, ShopModel shopModel, int index) {
    return ProductListView(
      productDetailModel: null,
      shopModel: shopModel,
      rightSideWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(Icons.location_on_outlined,
                  size: context.mediumValue,
                  color: context.colorScheme.onPrimary),
              onPressed: () {
                context.navigateToPage(HomeDashboardNavigationView(
                    isDirection: true, shopModel: shopModel));
              }),
          Container(
            height: context.dynamicHeight(0.04),
            child: NormalButton(
              child: Text(
               LocaleKeys.viewSellerText.locale,
                style: context.textTheme.titleMedium!
                    .copyWith(color: context.colorScheme.onSecondary),
              ),
              onPressed: null,
              color: context.appTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, ShopListViewModel viewModel) {
    return AppBar(
      elevation: 0.1,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Observer(builder: (_) {
        return viewModel.isSearching
            ? getAppBarListTile(context, viewModel)
            : Text(LocaleKeys.theNearestText.locale,
                style: context.textTheme.headline6!.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold));
      }),
      actions: [
        Observer(builder: (_) {
          return viewModel.isSearching
              ? SizedBox()
              : Padding(
                  padding: context.horizontalPaddingNormal,
                  child: IconButton(
                    onPressed: () {
                      viewModel.changeIsSearching();
                    },
                    icon: Icon(Icons.search, size: context.dynamicHeight(0.04)),
                  ),
                );
        })
      ],
    );
  }

  Widget getAppBarListTile(BuildContext context, ShopListViewModel viewModel) {
    return ListTile(
      title: TextFormField(
        textInputAction: TextInputAction.search,
        onChanged: (value) {},
        autofocus: true,
        onFieldSubmitted: (term) {
          viewModel.filterProducts(term);
        },
        decoration: InputDecoration(
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(8),
            hintText: LocaleKeys.enterShopNameText.locale,
            hintStyle: TextStyle(
              color: context.colorScheme.onSecondary.withOpacity(0.5),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            prefixIcon: Icon(Icons.search, size: context.dynamicHeight(0.03)),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.cancel_sharp, size: context.dynamicHeight(0.03)),
              onPressed: () {
                viewModel.changeIsSearching();
              },
            )),
      ),
    );
  }
}
