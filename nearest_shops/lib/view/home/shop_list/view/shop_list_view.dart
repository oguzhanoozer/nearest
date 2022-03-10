import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../product/contstants/image_path.dart';
import '../viewmodel/shop_list_view_model.dart';

class ShopListView extends StatelessWidget {
  const ShopListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ShopListViewModel>(
      viewModel: ShopListViewModel(),
      onModelReady: (model) {},
      onPageBuilder: (BuildContext context, ShopListViewModel viewmodel) =>
          buildScaffold(context, viewmodel),
    );
  }

  Widget buildScaffold(BuildContext context, ShopListViewModel viewmodel) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildProductList(),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: context.paddingLow,
          child: buildProductCard(context),
        );
      },
    );
  }

  Card buildProductCard(BuildContext context) {
    return Card(
      elevation: 2,
      borderOnForeground: true,
      shadowColor: context.colorScheme.onSurfaceVariant,
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: buildProductImage(context),
          ),
          Expanded(
            flex: 5,
            child: buildProductColumn(context),
          ),
          Expanded(
              flex: 1,
              child: Icon(Icons.location_on_outlined,
                  size: context.mediumValue * 1.5,
                  color: context.colorScheme.onPrimary)),
        ],
      ),
    );
  }

  Column buildProductColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildProductTitle(context),
        buildProductBody(context),
        buildProductPriceRow(context),
      ],
    );
  }

  Row buildProductPriceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("\$500",
            style: context.textTheme.headline6!.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.bold)),
        OutlinedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    context.colorScheme.onSurfaceVariant.withOpacity(0.9))),
            onPressed: null,
            child: Text(
              "See All Products",
              style: context.textTheme.bodyText1!
                  .copyWith(color: context.colorScheme.onSecondary),
            )),
      ],
    );
  }

  Text buildProductBody(BuildContext context) {
    return Text("Shop subtitle",
        style: context.textTheme.subtitle1!
            .copyWith(color: context.colorScheme.onPrimary));
  }

  Text buildProductTitle(BuildContext context) {
    return Text("Shop Title",
        style: context.textTheme.headline6!.copyWith(
            color: context.colorScheme.onPrimary, fontWeight: FontWeight.bold));
  }

  Padding buildProductImage(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Image.asset(
        ImagePaths.instance.hazelnut,
        height: context.dynamicHeight(0.1),
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
