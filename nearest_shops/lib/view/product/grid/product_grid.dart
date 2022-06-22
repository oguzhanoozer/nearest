import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../core/base/model/product_detail_view_arg.dart';
import '../../../core/base/route/generate_route.dart';
import '../../../core/components/card/list_item_card.dart';
import '../../home/categories/viewModel/categories_view_model.dart';
import '../../home/dashboard/viewmodel/dashboard_view_model.dart';
import '../../home/product_detail/model/product_detail_model.dart';
import '../../home/product_detail/view/product_detail_view.dart';
import '../contstants/image_path.dart';
import '../image/image_network.dart';
import '../input_text_decoration.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductDetailModel> productList;
  final DashboardViewModel? dashboardViewModel;
  final CategoriesViewModel? categoriesViewModel;

  ProductGrid({Key? key, this.dashboardViewModel, this.categoriesViewModel, required this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: productList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: context.paddingLow,
          child: buildProductCard(context, productList[index]),
        ),
      );
    });
  }

  Widget buildProductCard(BuildContext context, ProductDetailModel productDetailModel) {
    return GestureDetector(
      onTap: () async {
        bool currentFav = await Navigator.pushNamed(context, productDetailViewRoute,
            arguments: ProductDetailViewArguments(
              productDetailModel,
              checkProductInFavourite(dashboardViewModel, categoriesViewModel, productDetailModel),
            )) as bool;

        if (checkProductInFavourite(dashboardViewModel, categoriesViewModel, productDetailModel) != currentFav) {
          if (dashboardViewModel == null && categoriesViewModel != null) {
            await categoriesViewModel!.changeFavouriteList(productDetailModel.productId.toString());
          } else {
            await dashboardViewModel!.changeFavouriteList(productDetailModel.productId.toString());
          }
        }
      },
      child: ListItemCard(
        color: context.colorScheme.onSecondary,
        radius: context.normalValue,
        elevation: 0.5,
        borderSide: BorderSide(width: context.lowValue / 15, color: context.colorScheme.background),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 9,
              child: buildProductImage(productDetailModel, context),
            ),
            Expanded(
              flex: 5,
              child: buildProductDetail(context, productDetailModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductDetail(BuildContext context, ProductDetailModel productDetailModel) {
    return Observer(builder: (_) {
      return Padding(
        padding: context.paddingLow / 2,
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.onSecondary,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(context.normalValue), bottomRight: Radius.circular(context.normalValue)),
          ),
          child: Padding(
            padding: context.horizontalPaddingLow,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    productDetailModel.name ?? "",
                    textAlign: TextAlign.center,
                    style: titleTextStyle(context),
                    maxLines: 1,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(productDetailModel.summary ?? "", maxLines: 1, style: summaryTextStyle(context)),
                ),
                buildFavourContainer(productDetailModel, context)
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildFavourContainer(ProductDetailModel productDetailModel, BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            productDetailModel.price.toString(),
            style: priceTextStyle(context),
          ),
          buildFavourIconButton(productDetailModel, context),
        ],
      ),
    );
  }

  IconButton buildFavourIconButton(ProductDetailModel productDetailModel, BuildContext context) {
    return dashboardViewModel == null && categoriesViewModel != null
        ? IconButton(
            onPressed: () async {
              await categoriesViewModel!.changeFavouriteList(productDetailModel.productId.toString());
            },
            icon: Icon(Icons.favorite),
            color: checkProductInFavourite(dashboardViewModel, categoriesViewModel, productDetailModel)
                ? context.colorScheme.onPrimaryContainer
                : context.colorScheme.surface)
        : IconButton(
            onPressed: () async {
              await dashboardViewModel!.changeFavouriteList(productDetailModel.productId.toString());
            },
            icon: Icon(Icons.favorite),
            color: checkProductInFavourite(dashboardViewModel, categoriesViewModel, productDetailModel)
                ? context.colorScheme.onPrimaryContainer
                : context.colorScheme.surface);
  }

  Widget buildProductImage(ProductDetailModel productDetailModel, BuildContext context) {
    return ListItemCard(
      color: context.colorScheme.onSecondary,
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      radius: context.normalValue,
      child: productDetailModel.imageUrlList!.isEmpty
          ? Padding(padding: context.paddingMedium * 1.5, child: defaultProductImage(context, productDetailModel.categoryId!))
          : buildImageNetwork(productDetailModel.imageUrlList!.first.toString(), context),
    );
  }

  bool checkProductInFavourite(DashboardViewModel? dashboardViewModel, CategoriesViewModel? categoriesViewModel, ProductDetailModel productDetailModel) {
    if (dashboardViewModel == null && categoriesViewModel != null) {
      return categoriesViewModel.userFavouriteList.contains(productDetailModel.productId);
    } else {
      return dashboardViewModel!.userFavouriteList.contains(productDetailModel.productId);
    }
  }
}
