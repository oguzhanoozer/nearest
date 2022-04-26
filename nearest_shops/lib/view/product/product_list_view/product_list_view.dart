import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../core/components/card/list_item_card.dart';
import '../../home/product_detail/model/product_detail_model.dart';
import '../../home/shop_list/model/shop_model.dart';
import '../contstants/image_path.dart';

class ProductListView extends StatelessWidget {
  final ProductDetailModel? productDetailModel;
  final ShopModel? shopModel;

  final Widget? rightSideWidget;

  const ProductListView(
      {Key? key,
      required this.productDetailModel,
      this.rightSideWidget,
      this.shopModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.verticalPaddingLow,
      child: Container(
        height: context.dynamicHeight(0.12),
        child: ListItemCard(
          radius: context.normalValue,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: buildProductImage(
                    context,
                    productDetailModel == null && shopModel != null
                        ? shopModel!.logoUrl
                        : productDetailModel!.imageUrlList!.isEmpty
                            ? ""
                            : productDetailModel!.imageUrlList!.first),
              ),
              context.emptySizedWidthBoxLow3x,
              Expanded(
                flex: 4,
                child:
                    buildProductColumn(context, productDetailModel, shopModel),
              ),
              context.emptySizedWidthBoxLow3x,
              Expanded(flex: 2, child: rightSideWidget ?? SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  Column buildProductColumn(BuildContext context,
      ProductDetailModel? productDetailModel, ShopModel? shopModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildProductTitle(
            context,
            productDetailModel != null && shopModel == null
                ? productDetailModel.name.toString()
                : shopModel!.name!),
        buildProductBody(
            context,
            productDetailModel != null && shopModel == null
                ? productDetailModel.summary.toString()
                : shopModel!.address!),
        productDetailModel == null && shopModel != null
            ? buildEmailBody(context, shopModel.email!)
            : Container(),
        buildProductPriceRow(
            context,
            productDetailModel != null && shopModel == null
                ? productDetailModel.price.toString()
                : shopModel!.phoneNumber!),
      ],
    );
  }

  Row buildProductPriceRow(BuildContext context, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(price,
            style: context.textTheme.bodyText1!.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget buildEmailBody(BuildContext context, String email) {
    return FittedBox(
      child: Text(email,
          style: context.textTheme.bodySmall!
              .copyWith(color: context.colorScheme.onPrimary)),
    );
  }

  Widget buildProductBody(BuildContext context, String summaryTitle) {
    return FittedBox(
      child: Text(summaryTitle,
          style: context.textTheme.bodySmall!
              .copyWith(color: context.colorScheme.onPrimary)),
    );
  }

  Widget buildProductTitle(BuildContext context, String title) {
    return FittedBox(
      child: Text(title,
          style: context.textTheme.bodyText2!.copyWith(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget buildProductImage(BuildContext context, String? url) {
    return ListItemCard(
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      radius: context.normalValue,
      child: url == null || url.isEmpty
          ? Image.asset(
              ImagePaths.instance.hazelnut,
              //height: context.dynamicHeight(0.1),
              fit: BoxFit.fill,
            )
          : Image.network(
              url,
              //height: context.dynamicHeight(0.1),
              fit: BoxFit.fill,
            ),
    );
  }
}
