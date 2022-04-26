import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/extension/string_extension.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/card/list_item_card.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
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
        appBar: buildAppBar(context, viewModel),
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
      productDetailModel: productDetailModel,
      rightSideWidget: Column(
        children: [
          Expanded(
            child: IconButton(
              iconSize: 30,
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.edit,
                color: context.colorScheme.onSecondaryContainer,
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
                color: context.colorScheme.onPrimaryContainer,
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

  AppBar buildAppBar(
      BuildContext context, ShopOwnerProductListViewModel viewModel) {
    return AppBar(
      elevation: 0.1,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Observer(builder: (_) {
        return viewModel.isSearching
            ? getAppBarListTile(context, viewModel)
            : Text(LocaleKeys.yourProductsText.locale,
                style: context.textTheme.headline6!.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold));
      }),
      actions: [
        Observer(builder: (_) {
          return viewModel.isSearching
              ? SizedBox()
              : Padding(
                  padding: context.horizontalPaddingNormal,
                  child: IconButton(
                    onPressed: () {
                      viewModel.changeIsSearching();
                    },
                    icon: Icon(Icons.search, size: context.dynamicHeight(0.04)),
                  ),
                );
        })
      ],
    );
  }

  Widget getAppBarListTile(
      BuildContext context, ShopOwnerProductListViewModel viewModel) {
    return ListTile(
      title: TextFormField(
        textInputAction: TextInputAction.search,
        onChanged: (value) {},
        autofocus: true,
        onFieldSubmitted: (term) {
          viewModel.filterProducts(term);
        },
        decoration: InputDecoration(
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(8),
            hintText: LocaleKeys.enterProductNameText.locale,
            hintStyle: TextStyle(
              color: context.colorScheme.onSecondary.withOpacity(0.5),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            prefixIcon: Icon(Icons.search, size: context.dynamicHeight(0.03)),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.cancel_sharp, size: context.dynamicHeight(0.03)),
              onPressed: () {
                viewModel.changeIsSearching();
              },
            )),
      ),
    );
  }
}
