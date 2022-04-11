import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/card/list_item_card.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/product_list_view/product_list_view.dart';
import '../viewmodel/user_favourite_list_view_model.dart';

class UserFavouriteProductListView extends StatelessWidget {
  UserFavouriteProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<UserFavouriteListViewModel>(
      viewModel: UserFavouriteListViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, UserFavouriteListViewModel viewModel) =>
          buildScaffold(viewModel, context),
    );
  }

  Scaffold buildScaffold(
          UserFavouriteListViewModel viewModel, BuildContext context) =>
      Scaffold(
        key: viewModel.scaffoldState,
        appBar: buildAppBar(context),
        body: buildBody(viewModel, context),
      );

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text("Your Saved Products",
          style: context.textTheme.headline6!.copyWith(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.bold)),
      automaticallyImplyLeading: false,
    );
  }

  Widget buildBody(
          UserFavouriteListViewModel viewModel, BuildContext context) =>
      Observer(builder: (_) {
        return viewModel.isProductListLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                      child: showProductList(
                          viewModel.favouriteProductList, viewModel, context)),
                ],
              );
      });

  Widget showProductList(ObservableList<ProductDetailModel> productList,
      UserFavouriteListViewModel viewModel, BuildContext context) {
    return productList.isEmpty
        ? Center(
            child: Text("Favourite List Empty"),
          )
        : Padding(
            padding: context.paddingNormal,
            child: ListView.builder(
              /// controller: viewModel.controller,
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
      UserFavouriteListViewModel viewModel,
      int index) {
    return ProductListView(
      index: index,
      productDetailModel: productDetailModel,
      shopModel: null,
      rightSideWidget: IconButton(
        iconSize: 30,
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () async {
          await viewModel.removeFavouriteItem(index);
        },
      ),
    );
  }
}
