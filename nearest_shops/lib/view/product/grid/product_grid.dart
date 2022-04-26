import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../core/components/card/list_item_card.dart';
import '../../home/categories/viewModel/categories_view_model.dart';
import '../../home/dashboard/viewmodel/dashboard_view_model.dart';
import '../../home/product_detail/model/product_detail_model.dart';
import '../../home/product_detail/view/product_detail_view.dart';
import '../contstants/image_path.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductDetailModel> productList;
  final DashboardViewModel? dashboardViewModel;
  final CategoriesViewModel? categoriesViewModel;

  const ProductGrid(
      {Key? key,
      this.dashboardViewModel,
      this.categoriesViewModel,
      required this.productList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: productList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: context.paddingLow / 3,
        child: buildProductCard(context, productList[index]),
      ),
    );
  }

  Widget buildProductCard(
      BuildContext context, ProductDetailModel productDetailModel) {
    return GestureDetector(
        onTap: () => context.navigateToPage(ProductDetailView(
              productDetailModel: productDetailModel,
            )),
        child: ListItemCard(
          radius: context.normalValue,

          ///borderSide: BorderSide(              color: context.colorScheme.onInverseSurface, width: 0.5),
          elevation: 0.05,
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
        ));
  }

  Widget buildProductDetail(
      BuildContext context, ProductDetailModel productDetailModel) {
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
            children: [
              Text(
                productDetailModel.name ?? "",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge,
                maxLines: 1,
              ),
              Text(
                productDetailModel.summary ?? "",
                maxLines: 1,
              ),
              buildFavourContainer(productDetailModel, context)
            ],
          ),
        ),
      );
    });
  }

  Widget buildFavourContainer(
      ProductDetailModel productDetailModel, BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            productDetailModel.price.toString(),
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          buildFavourIconButton(productDetailModel,context),
        ],
      ),
    );
  }

  IconButton buildFavourIconButton(ProductDetailModel productDetailModel,BuildContext context) {
    return dashboardViewModel == null && categoriesViewModel!=null
        ? IconButton(
            onPressed: () async {
              await categoriesViewModel!
                  .changeFavouriteList(productDetailModel.productId.toString());
            },
            icon: Icon(Icons.favorite),
            color: categoriesViewModel!.userFavouriteList
                    .contains(productDetailModel.productId)
                ? context.colorScheme.onPrimaryContainer
                : context.colorScheme.surface)
        : IconButton(
            onPressed: () async {
              await dashboardViewModel!
                  .changeFavouriteList(productDetailModel.productId.toString());
            },
            icon: Icon(Icons.favorite),
            color: dashboardViewModel!.userFavouriteList
                    .contains(productDetailModel.productId)
                ? context.colorScheme.onPrimaryContainer
                : context.colorScheme.surface);
  }

  Center buildProductImage(
      ProductDetailModel productDetailModel, BuildContext context) {
    return Center(
      child: ListItemCard(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        radius: context.normalValue,
        child: productDetailModel.imageUrlList!.isEmpty
            ? Image.asset(ImagePaths.instance.hazelnut, fit: BoxFit.fill)
            : Image.network(productDetailModel.imageUrlList!.first.toString(),
                fit: BoxFit.fill),
      ),
    );
  }
}
