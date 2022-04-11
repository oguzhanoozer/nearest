import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/card/list_item_card.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/product_list_view/product_list_view.dart';
import '../../add_product/view/add_product_view.dart';
import '../viewmodel/shop_owner_product_list_view_model.dart';

class ShopOwnerProductListView extends StatelessWidget {
  ShopOwnerProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ShopOwnerProductListViewModel>(
      viewModel: ShopOwnerProductListViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, ShopOwnerProductListViewModel viewModel) =>
          buildScaffold(viewModel, context),
    );
  }

  Scaffold buildScaffold(
          ShopOwnerProductListViewModel viewModel, BuildContext context) =>
      Scaffold(
        key: viewModel.scaffoldState,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Your Products"),
          automaticallyImplyLeading: false,
          elevation: 0.5,
        ),
        body: buildBody(viewModel, context),
      );

  Widget buildBody(
          ShopOwnerProductListViewModel viewModel, BuildContext context) =>
      Observer(builder: (_) {
        return viewModel.isProductFirstListLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                      child: showProductList(
                          viewModel.productList, viewModel, context)),
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
      ShopOwnerProductListViewModel viewModel, BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: ListView.builder(
        controller: viewModel.controller,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return buildProductCard(
              context, productList[index], viewModel, index);
        },
      ),
    );
  }

  Widget buildProductCard(
      BuildContext context,
      ProductDetailModel productDetailModel,
      ShopOwnerProductListViewModel viewModel,
      int index) {
    return ProductListView(
      index: index,
      productDetailModel: productDetailModel,
      rightSideWidget: Column(
        children: [
          Expanded(
            child: IconButton(
              iconSize: 30,
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.edit,
                color: Colors.green,
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
          ),
          Expanded(
            child: IconButton(
              iconSize: 30,
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {
                await viewModel.deleteProduct(
                  productId: productDetailModel.productId.toString(),
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
