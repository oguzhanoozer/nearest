import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../core/base/model/product_detail_view_arg.dart';
import '../../../core/base/route/generate_route.dart';
import '../../../core/components/card/list_item_card.dart';
import '../../home/dashboard/viewmodel/dashboard_view_model.dart';
import '../../home/product_detail/model/product_detail_model.dart';
import '../../home/product_detail/view/product_detail_view.dart';
import '../contstants/image_path.dart';
import '../image/image_network.dart';
import '../input_text_decoration.dart';

class SliderCard extends StatelessWidget {
  final BuildContext context;
  final ProductDetailModel productDetailModel;
  final bool onlyImage;
  final DashboardViewModel viewmodel;
  const SliderCard({Key? key, required this.context, required this.productDetailModel, required this.onlyImage, required this.viewmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool currentFav = Navigator.pushNamed(context, productDetailViewRoute,
            arguments: ProductDetailViewArguments(
              productDetailModel,
              viewmodel.userFavouriteList.contains(productDetailModel.productId),
            )) as bool;

        if (viewmodel.userFavouriteList.contains(productDetailModel.productId) != currentFav) {
          await viewmodel.changeFavouriteList(productDetailModel.productId.toString());
        }
      },
      child: ListItemCard(
        color: context.colorScheme.onSecondary,
        radius: context.normalValue,
        elevation: 0.3,
        borderSide: BorderSide(width: context.lowValue / 15, color: context.colorScheme.background),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildProductImage(context, productDetailModel),
            ),
            onlyImage
                ? Container()
                : Expanded(
                    flex: 3,
                    child: buildProductDetail(productDetailModel, context, viewmodel),
                  ),
          ],
        ),
      ),
    );
  }

  static Widget buildProductDetail(ProductDetailModel productDetailModel, BuildContext context, DashboardViewModel viewmodel) {
    return Padding(
      padding: context.paddingLow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildProductTitle(productDetailModel, context),
          buildProductSummary(productDetailModel, context),
          buildProductPriceRow(productDetailModel, context, viewmodel),
        ],
      ),
    );
  }

  static Widget buildProductPriceRow(ProductDetailModel productDetailModel, BuildContext context, DashboardViewModel viewmodel) {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(productDetailModel.price.toString(), style: priceTextStyle(context)),
          IconButton(
              onPressed: () {
                viewmodel.changeFavouriteList(productDetailModel.productId.toString());
              },
              icon: Icon(Icons.favorite),
              color: viewmodel.userFavouriteList.contains(productDetailModel.productId) ? context.colorScheme.onPrimaryContainer : context.colorScheme.surface),
        ],
      );
    });
  }

  static Text buildProductSummary(ProductDetailModel productDetailModel, BuildContext context) =>
      Text(productDetailModel.summary ?? "", maxLines: 3, style: summaryTextStyle(context));

  static Text buildProductTitle(ProductDetailModel productDetailModel, BuildContext context) {
    return Text(productDetailModel.name ?? "", maxLines: 1, style: titleTextStyle(context));
  }

  static Widget buildProductImage(BuildContext context, ProductDetailModel productDetailModel) {
    return ListItemCard(
      color: context.colorScheme.onSecondary,
      radius: context.normalValue,
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: productDetailModel.imageUrlList!.isEmpty
          ? Padding(
              padding: context.paddingMedium,
              child:   defaultProductImage(context, productDetailModel.categoryId!)
            )
          : buildImageNetwork(productDetailModel.imageUrlList!.first.toString(), context),
    );
  }
}
