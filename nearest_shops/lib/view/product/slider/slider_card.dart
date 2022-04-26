import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../core/components/card/list_item_card.dart';
import '../../home/dashboard/viewmodel/dashboard_view_model.dart';
import '../../home/product_detail/model/product_detail_model.dart';
import '../../home/product_detail/view/product_detail_view.dart';
import '../contstants/image_path.dart';

class SliderCard extends StatelessWidget {
  final BuildContext context;
  final ProductDetailModel productDetailModel;
  final bool onlyImage;
  final DashboardViewModel viewmodel;
  const SliderCard(
      {Key? key,
      required this.context,
      required this.productDetailModel,
      required this.onlyImage,
      required this.viewmodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => context.navigateToPage(ProductDetailView(
            productDetailModel: productDetailModel,
          ))),
      child: ListItemCard(
        radius: context.normalValue,

        ///borderSide: BorderSide(              color: context.colorScheme.onInverseSurface, width: 0.5),
        elevation: 0.3,
        child: Padding(
          padding: context.paddingLow,
          child: Row(
            children: [
              Expanded(
                child: buildProductImage(context, productDetailModel),
              ),
              onlyImage
                  ? Container()
                  : Expanded(
                      child: buildProductDetail(
                          productDetailModel, context, viewmodel),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  static Column buildProductDetail(ProductDetailModel productDetailModel,
      BuildContext context, DashboardViewModel viewmodel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildProductTitle(productDetailModel, context),
        buildProductSummary(productDetailModel, context),
        buildProductPriceRow(productDetailModel, context, viewmodel),
      ],
    );
  }

  static Widget buildProductPriceRow(ProductDetailModel productDetailModel,
      BuildContext context, DashboardViewModel viewmodel) {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            productDetailModel.price.toString(),
            style: context.textTheme.bodyText2!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          IconButton(
              onPressed: () {
                viewmodel.changeFavouriteList(
                    productDetailModel.productId.toString());
              },
              icon: Icon(Icons.favorite),
              color: viewmodel.userFavouriteList
                      .contains(productDetailModel.productId)
                  ? context.colorScheme.onPrimaryContainer
                  : context.colorScheme.surface),
        ],
      );
    });
  }

  static Text buildProductSummary(
          ProductDetailModel productDetailModel, BuildContext context) =>
      Text(productDetailModel.summary ?? "",
          style: context.textTheme.bodySmall!);

  static Text buildProductTitle(
      ProductDetailModel productDetailModel, BuildContext context) {
    return Text(
      productDetailModel.name ?? "",
      style: context.textTheme.bodyLarge!
          .copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.primary),
    );
  }

  static Widget buildProductImage(
      BuildContext context, ProductDetailModel productDetailModel) {
    return ListItemCard(
      radius: context.normalValue,
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: productDetailModel.imageUrlList!.isEmpty
          ? Image.asset(
              ImagePaths.instance.hazelnut,
              fit: BoxFit.fill,
            )
          : Image.network(
              productDetailModel.imageUrlList!.first.toString(),
              fit: BoxFit.fill,
            ),
    );
  }
}
