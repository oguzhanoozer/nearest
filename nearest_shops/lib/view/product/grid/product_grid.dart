import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../home/dashboard/model/dashboard_model.dart';
import '../../home/dashboard/viewmodel/dashboard_view_model.dart';
import '../../home/product_detail/model/product_detail_model.dart';
import '../contstants/image_path.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductDetailModel> productList;
  final DashboardViewModel viewModel;

  const ProductGrid(
      {Key? key, required this.viewModel, required this.productList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: productList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: context.paddingLow / 3,
        child: buildProductCard(context, index),
      ),
    );
  }

  Card buildProductCard(BuildContext context, int index) {
    return Card(
      /// color: context.colorScheme.onInverseSurface,
      shadowColor: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        side:
            BorderSide(color: context.colorScheme.onInverseSurface, width: 0.5),
        borderRadius: BorderRadius.circular(context.normalValue),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: buildProductImage(index, context),
          ),
          Expanded(
            flex: 5,
            child: buildProductDetail(context, index),
          ),
        ],
      ),
    );
  }

  Widget buildProductDetail(BuildContext context, int index) {
    return Observer(builder: (_) {
      return Padding(
        padding: context.paddingLow / 2,
        child: Container(
          decoration: BoxDecoration(
              color: context.colorScheme.onSecondary,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(context.normalValue),
                  bottomRight: Radius.circular(context.normalValue))),
          child: Column(
            ///  mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                productList[index].name ?? "",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge,
                maxLines: 1,
              ),
              Text(
                productList[index].summary ?? "",
                maxLines: 1,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      productList[index].price.toString(),
                      style: context.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.shopping_bag),
                    IconButton(
                        onPressed: () async {
                          await viewModel.changeFavouriteList(
                              productList[index].productId.toString());
                        },
                        icon: Icon(Icons.favorite),
                        color: viewModel.userFavouriteList
                                .contains(productList[index].productId)
                            ? Colors.red
                            : Colors.grey),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Center buildProductImage(int index, BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,

        /// borderOnForeground: true,
        shape: RoundedRectangleBorder(
          /// side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: productList[index].imageUrlList!.isEmpty
            ? Image.asset(ImagePaths.instance.hazelnut, fit: BoxFit.fill)
            : Image.network(productList[index].imageUrlList!.first.toString(),
                fit: BoxFit.fill),
      ),
    );
  }
}
