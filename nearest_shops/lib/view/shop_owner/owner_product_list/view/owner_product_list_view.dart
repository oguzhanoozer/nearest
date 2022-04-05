import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../../../product/contstants/image_path.dart';
import '../../add_product/view/add_product_view.dart';
import '../../add_product/viewmodel/add_product_view_model.dart';
import '../viewmodel/owner_product_list_view_model.dart';

class OwnerProductListView extends StatelessWidget {
  OwnerProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OwnerProductListViewModel>(
      viewModel: OwnerProductListViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, OwnerProductListViewModel viewModel) =>
          buildScaffold(viewModel),
    );
  }

  Scaffold buildScaffold(OwnerProductListViewModel viewModel) => Scaffold(
        key: viewModel.scaffoldState,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Your Products"),
        ),
        body: buildBody(viewModel),
      );

  Widget buildBody(OwnerProductListViewModel viewModel) =>
      Observer(builder: (_) {
        return viewModel.isProductFirstListLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                      child: showProductList(viewModel.productList, viewModel)),
                  if (viewModel.isProductMoreListLoading == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
      });

  Widget showProductList(ObservableList<ProductDetailModel> productList,
      OwnerProductListViewModel viewModel) {
    return ListView.builder(
      controller: viewModel.controller,
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return Card(
          child:
              buildProductCard(context, productList[index], viewModel, index),
        );
        /*Slidable(
          closeOnScroll: true,
          key: const ValueKey(0),
          endActionPane: ActionPane(
            extentRatio: 0.5,
            dragDismissible: false,
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                onPressed: (context) {
                  context.navigateToPage(AddProductView(
                    isUpdate: true,
                    productDetailModel: productList[index],
                  ));
                },
                backgroundColor: Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Update',
              ),
              SlidableAction(
                // ignore: avoid_print
                onPressed: (context) async {
                  await viewModel.deleteProduct(
                    productId: productList[index].productId.toString(),
                    index: index,
                  );
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Card(
            child:
                buildProductCard(context, productList[index], viewModel, index),
          ),
        );*/
      },
    );
  }

  Card buildProductCard(
      BuildContext context,
      ProductDetailModel productDetailModel,
      OwnerProductListViewModel viewModel,
      int index) {
    return Card(
      elevation: 2,
      borderOnForeground: true,
      shadowColor: context.colorScheme.onSurfaceVariant,
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: buildProductImage(context, productDetailModel),
          ),
          Expanded(
            flex: 3,
            child: buildProductColumn(context, productDetailModel),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF21B7CA),
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.navigateToPage(
                      AddProductView(
                        isUpdate: true,
                        productDetailModel: productDetailModel,
                      ),
                    );
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFFE4A49),
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await viewModel.deleteProduct(
                      productId: productDetailModel.productId.toString(),
                      index: index,
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column buildProductColumn(
      BuildContext context, ProductDetailModel productDetailModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildProductTitle(context, productDetailModel.name.toString()),
        buildProductBody(context, productDetailModel.summary.toString()),
        buildProductPriceRow(context, productDetailModel.price.toString()),
      ],
    );
  }

  Row buildProductPriceRow(BuildContext context, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(price,
            style: context.textTheme.headline6!.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Text buildProductBody(BuildContext context, String summaryTitle) {
    return Text(summaryTitle,
        style: context.textTheme.subtitle1!
            .copyWith(color: context.colorScheme.onPrimary));
  }

  Text buildProductTitle(BuildContext context, String title) {
    return Text(title,
        style: context.textTheme.headline6!.copyWith(
            color: context.colorScheme.onPrimary, fontWeight: FontWeight.bold));
  }

  Widget buildProductImage(
      BuildContext context, ProductDetailModel productDetailModel) {
    return Padding(
        padding: context.paddingNormal,
        child: productDetailModel.imageUrlList!.isEmpty
            ? Image.asset(
                ImagePaths.instance.hazelnut,
                height: context.dynamicHeight(0.1),
              )
            : Image.network(
                productDetailModel.imageUrlList!.first.toString(),
                height: context.dynamicHeight(0.1),
              ));
  }
}
