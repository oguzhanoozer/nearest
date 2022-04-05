import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/home/product_detail/model/product_detail_model.dart';

import '../../home/dashboard/model/dashboard_model.dart';
import '../../home/dashboard/viewmodel/dashboard_view_model.dart';
import '../contstants/image_path.dart';

class SliderCard extends Card {
  final BuildContext context;
  final ProductDetailModel productDetailModel;
  final bool onlyImage;
  final DashboardViewModel viewmodel;

  SliderCard({
    required this.productDetailModel,
    required this.context,
    required this.onlyImage,
    required this.viewmodel,
  }) : super(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(width: 1, color: Colors.orange[100]!)),
          child: Padding(
            padding: context.paddingLow,
            child: Row(
              children: [
                Expanded(
                  //child: Image.network(widget.dashboardModelList![index].url ?? "",
                  child: buildProductImage(productDetailModel),
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
        );

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
          Icon(Icons.shopping_bag),
          IconButton(
              onPressed: () {
                viewmodel.changeFavouriteList(
                    productDetailModel.productId.toString());
              },
              icon: Icon(Icons.favorite),
              color: viewmodel.userFavouriteList
                      .contains(productDetailModel.productId)
                  ? Colors.red
                  : Colors.grey),
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
          .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  static Widget buildProductImage(ProductDetailModel productDetailModel) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: productDetailModel.imageUrlList!.isEmpty
          ? Image.asset(
              ImagePaths.instance.hazelnut,
              //  height: context.dynamicHeight(0.1),
              fit: BoxFit.fill,
            )
          : Image.network(
              productDetailModel.imageUrlList!.first.toString(),
              fit: BoxFit.fill,
            ),
    );

    ///Image.asset(dashboardModel.imageUrlList.first ?? "", fit: BoxFit.fill);
  }
}
