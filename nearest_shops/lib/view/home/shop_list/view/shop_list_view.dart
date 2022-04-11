import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/card/list_item_card.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/product_list_view/product_list_view.dart';
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
    return Scaffold(
        key: viewmodel.scaffoldState,
        appBar: buildAppBar(context),
        body: Observer(builder: (_) {
          return viewmodel.isShopMapListLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : buildShopList(viewmodel, context);
        }));
  }

  Widget buildShopList(ShopListViewModel viewmodel, BuildContext context) {
    List<ShopModel> currentShopList = viewmodel.getListShopModel();

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
      index: index,
      productDetailModel: null,
      shopModel: shopModel,
      rightSideWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.location_on_outlined,
              size: context.mediumValue, color: context.colorScheme.onPrimary),
          Container(
            height: 30,
            child: NormalButton(
              child: Text(
                "View Seller",
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.1,
      automaticallyImplyLeading: false,

      centerTitle: true,
      title: Text("Nearest Shops",
          style: context.textTheme.headline6!.copyWith(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.bold)),
    );
  }
}
