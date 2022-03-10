import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'map_shop_view.dart';
import '../viewmodel/owner_product_list_view_model.dart';
import '../../../product/slider/slider_card.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/button/text_button.dart';

part 'subview/owner_product_extension.dart';

class OwnerProductListView extends StatelessWidget {
  const OwnerProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OwnerProductListViewModel>(
      viewModel: OwnerProductListViewModel(),
      onModelReady: (model) {},
      onPageBuilder:
          (BuildContext context, OwnerProductListViewModel viewmodel) =>
              buildScaffold(context, viewmodel),
    );
  }

  Widget buildScaffold(
      BuildContext context, OwnerProductListViewModel viewmodel) {
    return Scaffold(
      body: Stack(
        children: [
          MapShopView(),
          buildSearchTextField(context),
          buildDraggeableContainer(viewmodel)
        ],
      ),
    );
  }

  DraggableScrollableSheet buildDraggeableContainer(
      OwnerProductListViewModel viewmodel) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      maxChildSize: 0.8,
      builder: (BuildContext context, myscrollController) {
        return Padding(
          padding: context.horizontalPaddingLow,
          child: Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: context.colorScheme.onSecondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.normalValue),
                topRight: Radius.circular(context.normalValue),
              ),
            ),
            child: buildProductListView(myscrollController, viewmodel),
          ),
        );
      },
    );
  }

  ListView buildProductListView(ScrollController myscrollController,
      OwnerProductListViewModel viewmodel) {
    return ListView.builder(
      controller: myscrollController,
      itemCount: viewmodel.dashboardModelList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: context.paddingNormal,
          child: buildProductCard(context, viewmodel, index),
        );
      },
    );
  }

  Card buildProductCard(
      BuildContext context, OwnerProductListViewModel viewmodel, int index) {
    return Card(
      elevation: 2,
      borderOnForeground: true,
      shadowColor: context.colorScheme.onSurfaceVariant.withOpacity(0.5),
      margin: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProductImage(context, viewmodel, index),
          buildProductDetail(viewmodel, index, context),
        ],
      ),
    );
  }

  Expanded buildProductDetail(
      OwnerProductListViewModel viewmodel, int index, BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildProductTitle(viewmodel, index, context),
          buildProductBody(viewmodel, index),
          context.emptySizedHeightBoxLow3x,
          buildProductPriceRow(viewmodel, index, context),
        ],
      ),
    );
  }

  Row buildProductPriceRow(
      OwnerProductListViewModel viewmodel, int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          viewmodel.dashboardModelList[index].price ?? "",
          style: context.textTheme.headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Icon(Icons.shopping_bag),
        buildAllSeeProductButton(context),
      ],
    );
  }

  ElevatedButton buildAllSeeProductButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent)),
      child: Text(
        "Own other products",
        style: context.textTheme.bodyLarge!
            .copyWith(color: context.colorScheme.onSurfaceVariant),
      ),
      onPressed: () {},
    );
  }

  Text buildProductBody(OwnerProductListViewModel viewmodel, int index) =>
      Text(viewmodel.dashboardModelList[index].body ?? "");

  Text buildProductTitle(
      OwnerProductListViewModel viewmodel, int index, BuildContext context) {
    return Text(
      viewmodel.dashboardModelList[index].title ?? "",
      style: context.textTheme.headline5!.copyWith(
          fontWeight: FontWeight.bold, color: context.colorScheme.primary),
    );
  }

  Expanded buildProductImage(
      BuildContext context, OwnerProductListViewModel viewmodel, int index) {
    return Expanded(
      flex: 1,
      //child: Image.network(widget.dashboardModelList![index].url ?? "",
      child: Padding(
        padding: context.paddingNormal,
        child: Image.asset(
          viewmodel.dashboardModelList[index].url ?? "",
          fit: BoxFit.fill,
          height: context.dynamicHeight(0.1),
        ),
      ),
    );
  }
}
