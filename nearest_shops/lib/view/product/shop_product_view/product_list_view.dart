import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

import '../../../core/components/card/list_item_card.dart';
import '../../home/product_detail/model/product_detail_model.dart';
import '../../home/shop_list/model/shop_model.dart';
import '../contstants/image_path.dart';
import '../image/image_network.dart';
import '../input_text_decoration.dart';

class ShopProductView extends StatelessWidget {
  final ProductDetailModel? productDetailModel;
  final ShopModel? shopModel;

  final Widget? rightSideWidget;

  const ShopProductView({Key? key, required this.productDetailModel, this.rightSideWidget, this.shopModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.verticalPaddingLow,
      child: SizedBox(
        height: context.dynamicHeight(0.15),
        child: ListItemCard(
          color: context.colorScheme.onSecondary,
          radius: context.normalValue,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: buildProductImage(
                    productDetailModel?.categoryId!,
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
                child: Padding(
                  padding: context.paddingLow,
                  child: buildProductColumn(context, productDetailModel, shopModel),
                ),
              ),
              context.emptySizedWidthBoxLow3x,
              Expanded(flex: 2, child: rightSideWidget ?? SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  Column buildProductColumn(BuildContext context, ProductDetailModel? productDetailModel, ShopModel? shopModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildProductTitle(context, productDetailModel != null && shopModel == null ? productDetailModel.name.toString() : shopModel!.name!),
        buildProductSummary(context, productDetailModel != null && shopModel == null ? productDetailModel.summary.toString() : shopModel!.address!),
        productDetailModel == null && shopModel != null ? buildEmailBody(context, shopModel.email!) : Container(),
        buildProductPriceRow(context, productDetailModel != null && shopModel == null ? productDetailModel.price.toString() : shopModel!.phoneNumber!),
      ],
    );
  }

  Row buildProductPriceRow(BuildContext context, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(price, style: priceTextStyle(context)),
      ],
    );
  }

  Widget buildEmailBody(BuildContext context, String email) {
    return Text(email, maxLines: 1, style: emailTextStyle(context));
  }

  Widget buildProductSummary(BuildContext context, String summaryTitle) {
    return Text(summaryTitle, maxLines: 3, style: summaryTextStyle(context));
  }

  Widget buildProductTitle(BuildContext context, String title) {
    return Text(title, maxLines: 1, style: titleTextStyle(context));
  }

  Widget buildProductImage(int? categoryId, BuildContext context, String? url) {
    return ListItemCard(
      color: context.colorScheme.onSecondary,
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      radius: context.normalValue,
      child: url == null || url.isEmpty
          ? categoryId != null
              ? Padding(
                  padding: context.paddingMedium,
                  child:  defaultProductImage(context, categoryId)
                )
              : Padding(
                  padding: context.paddingLow,
                  child: Lottie.asset(
                    ImagePaths.instance.shop_lottie3,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                )
          : buildImageNetwork(url, context),
    );
  }
}
