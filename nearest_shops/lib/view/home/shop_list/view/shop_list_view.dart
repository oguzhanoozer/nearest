import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/home/shop_list/model/shop_model.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../product/contstants/image_path.dart';
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

  Widget buildScaffold(BuildContext context, ShopListViewModel viewmodel) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Observer(builder: (_) {
          return viewmodel.isShopMapListLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : buildShopList(viewmodel);
        }));
  }

  Widget buildShopList(ShopListViewModel viewmodel) {
    List<ShopModel> currentShopList = viewmodel.getListShopModel();

    return ListView.builder(
      itemCount: currentShopList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: context.paddingLow,
          child: buildShopCard(context, currentShopList[index]),
        );
      },
    );
  }

  Card buildShopCard(BuildContext context, ShopModel shopModel) {
    return Card(
      elevation: 2,
      borderOnForeground: true,

      /// shadowColor: context.colorScheme.onSurfaceVariant,
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: buildShopImage(context, shopModel),
          ),
          Expanded(
            flex: 3,
            child: buildShopColumn(context, shopModel),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Icon(Icons.location_on_outlined,
                    size: context.mediumValue,
                    color: context.colorScheme.onPrimary),
                OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(context
                          .colorScheme.onSurfaceVariant
                          .withOpacity(0.9))),
                  onPressed: null,
                  child: Text(
                    "View Seller",
                    style: context.textTheme.bodyText1!
                        .copyWith(color: context.colorScheme.onSecondary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildShopColumn(BuildContext context, ShopModel shopModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildShopTitle(context, shopModel),
        buildShopBody(context, shopModel),
        buildShopPriceRow(context, shopModel),
      ],
    );
  }

  Row buildShopPriceRow(BuildContext context, ShopModel shopModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(shopModel.phoneNumber!,
            style: context.textTheme.headline6!.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Text buildShopBody(BuildContext context, ShopModel shopModel) {
    return Text(shopModel.address!,
        style: context.textTheme.subtitle1!
            .copyWith(color: context.colorScheme.onPrimary));
  }

  Text buildShopTitle(BuildContext context, ShopModel shopModel) {
    return Text(shopModel.name!,
        style: context.textTheme.headline6!.copyWith(
            color: context.colorScheme.onPrimary, fontWeight: FontWeight.bold));
  }

  Widget buildShopImage(BuildContext context, ShopModel shopModel) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: shopModel.logoUrl!.isEmpty
          ? Image.asset(
              ImagePaths.instance.hazelnut,
              height: context.dynamicHeight(0.15),
              fit: BoxFit.fill,
            )
          : Image.network(
              shopModel.logoUrl.toString(),
              height: context.dynamicHeight(0.15),
              fit: BoxFit.fill,
            ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 3,
      shadowColor: context.colorScheme.onSurfaceVariant.withOpacity(0.5),
      centerTitle: true,
      title: Text("Nearest Shops",
          style: context.textTheme.headline5!.copyWith(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.bold)),
    );
  }
}
