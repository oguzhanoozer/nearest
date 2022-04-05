import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../../../product/contstants/image_path.dart';
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
          buildScaffold(viewModel),
    );
  }

  Scaffold buildScaffold(UserFavouriteListViewModel viewModel) => Scaffold(
        key: viewModel.scaffoldState,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Your Saved Products"),
        ),
        body: buildBody(viewModel),
      );

  Widget buildBody(UserFavouriteListViewModel viewModel) =>
      Observer(builder: (_) {
        return viewModel.isProductListLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                      child: showProductList(
                          viewModel.favouriteProductList, viewModel)),
                  /*
                  if (viewModel.isProductMoreListLoading == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    */
                ],
              );
      });

  Widget showProductList(ObservableList<ProductDetailModel> productList,
      UserFavouriteListViewModel viewModel) {
    return productList.isEmpty
        ? Center(
            child: Text("Favourite List Empty"),
          )
        : ListView.builder(
            /// controller: viewModel.controller,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Card(
                child: buildProductCard(
                    context, productList[index], viewModel, index),
              );
              /*
               Slidable(
                closeOnScroll: true,
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  extentRatio: 0.5,
                  dragDismissible: false,
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      // ignore: avoid_print
                      onPressed: (context) async {
                        await viewModel.removeFavouriteItem(index);
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Card(
                  child: buildProductCard(context, productList[index]),
                ),
              );*/
            },
          );
  }

  Card buildProductCard(
      BuildContext context,
      ProductDetailModel productDetailModel,
      UserFavouriteListViewModel viewModel,
      int index) {
    return Card(
      elevation: 2,
      borderOnForeground: true,
      shadowColor: context.colorScheme.onSurfaceVariant,
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: buildProductImage(context, productDetailModel),
          ),
          context.emptySizedWidthBoxLow,
          Expanded(
            flex: 4,
            child: buildProductColumn(context, productDetailModel),
          ),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: context.colorScheme.onSurfaceVariant,
                      shape: CircleBorder(),
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await viewModel.removeFavouriteItem(index);
                    },
                  ),
                ],
              )),
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
      padding: context.paddingLow,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: productDetailModel.imageUrlList!.isEmpty
            ? Image.asset(
                ImagePaths.instance.hazelnut,
                height: context.dynamicHeight(0.1),
                fit: BoxFit.fill,
              )
            : Image.network(
                productDetailModel.imageUrlList!.first.toString(),
                height: context.dynamicHeight(0.1),
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}
