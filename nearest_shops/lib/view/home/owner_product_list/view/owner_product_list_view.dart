import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../product/contstants/image_path.dart';
import '../viewmodel/owner_product_list_view_model.dart';
import 'map_shop_view.dart';

part 'subview/owner_product_extension.dart';

class OwnerUserProductListView extends StatelessWidget {
  const OwnerUserProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OwnerProductListViewModel>(
      viewModel: OwnerProductListViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, OwnerProductListViewModel viewmodel) =>
              buildScaffold(context, viewmodel),
    );
  }

  Widget buildScaffold(
      BuildContext context, OwnerProductListViewModel viewmodel) {
    return Observer(builder: (_) {
      return Scaffold(
        body: viewmodel.isShopMapLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  MapShopView(viewModel: viewmodel),
                  buildSearchTextField(context),
                  viewmodel.isShopProductLoaded
                      ? buildDraggeableContainer(viewmodel)
                      : Container()
                ],
              ),
      );
    });
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
            child: viewmodel.isShopProductLoading
                ? Center(child: CircularProgressIndicator())
                : buildProductListView(myscrollController, viewmodel),
          ),
        );
      },
    );
  }

  ListView buildProductListView(ScrollController myscrollController,
      OwnerProductListViewModel viewmodel) {
    return ListView.builder(
      controller: myscrollController,
      itemCount: viewmodel.getListProductDetailModel().length,
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
          context.emptySizedWidthBoxLow,
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
          viewmodel.getListProductDetailModel()[index].price!.toString(),
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
      Text(viewmodel.getListProductDetailModel()[index].summary ?? "");

  Text buildProductTitle(
      OwnerProductListViewModel viewmodel, int index, BuildContext context) {
    return Text(
      viewmodel.getListProductDetailModel()[index].name ?? "",
      style: context.textTheme.headline5!.copyWith(
          fontWeight: FontWeight.bold, color: context.colorScheme.primary),
    );
  }

  Expanded buildProductImage(
      BuildContext context, OwnerProductListViewModel viewmodel, int index) {
    return Expanded(
      flex: 1,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,

        /// borderOnForeground: true,
        shape: RoundedRectangleBorder(
          /// side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child:
            viewmodel.getListProductDetailModel()[index].imageUrlList!.isEmpty
                ? Image.asset(
                    ImagePaths.instance.hazelnut,
                    height: context.dynamicHeight(0.15),
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    viewmodel
                        .getListProductDetailModel()[index]
                        .imageUrlList!
                        .first
                        .toString(),
                    height: context.dynamicHeight(0.15),
                    fit: BoxFit.fill,
                  ),
      ),
    );
  }
}
