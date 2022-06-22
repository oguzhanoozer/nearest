import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';

import '../../../../core/base/model/add_product_view_arg.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/input_text_decoration.dart';
import '../../../product/shop_product_view/product_list_view.dart';
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
      onPageBuilder: (context, ShopOwnerProductListViewModel viewModel) => buildScaffold(viewModel, context),
    );
  }

  Scaffold buildScaffold(ShopOwnerProductListViewModel viewModel, BuildContext context) => Scaffold(
        key: viewModel.scaffoldState,
        appBar: buildAppBar(context, viewModel),
        body: buildBody(viewModel, context),
      );

  Widget buildBody(ShopOwnerProductListViewModel viewModel, BuildContext context) => Observer(builder: (_) {
        return viewModel.isProductFirstListLoading
            ? CallCircularProgress(context)
            : Column(
                children: [
                  Observer(builder: (_) {
                    return Expanded(child: showProductList(viewModel.productList, viewModel, context));
                  }),
                  if (viewModel.isProductMoreListLoading == true)
                    Padding(
                        padding: EdgeInsets.only(top: context.dynamicHeight(0.01), bottom: context.dynamicHeight(0.03)), child: CallCircularProgress(context)),
                ],
              );
      });

  Widget showProductList(ObservableList<ProductDetailModel> productList, ShopOwnerProductListViewModel viewModel, BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Observer(builder: (_) {
        return ListView.builder(
          controller: viewModel.controller,
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return buildProductCard(context, productList[index], viewModel, index);
          },
        );
      }),
    );
  }

  Widget buildProductCard(BuildContext context, ProductDetailModel productDetailModel, ShopOwnerProductListViewModel viewModel, int index) {
    return Observer(builder: (_) {
      return ShopProductView(
        productDetailModel: productDetailModel,
        rightSideWidget: Column(
          children: [
            Expanded(
              child: IconButton(
                iconSize: 30,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.edit,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                onPressed: () async {
                  ProductDetailModel? productDetailModelUpdated = await Navigator.pushNamed(context, addProductViewRoute,
                      arguments: AddProductViewArguments(
                        productDetailModel,
                        isUpdate: true,
                      )) as ProductDetailModel?;

                  if (productDetailModelUpdated != null) {
                    viewModel.changeProductList(index, productDetailModelUpdated);
                  }
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
    });
  }

  AppBar buildAppBar(BuildContext context, ShopOwnerProductListViewModel viewModel) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Observer(builder: (_) {
        return viewModel.isSearching
            ? getAppBarListTile(context, viewModel)
            : Text(LocaleKeys.yourProductsText.locale,
                style: GoogleFonts.concertOne(
                    textStyle: context.textTheme.headline5!.copyWith(color: context.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold)));
      }),
      actions: [
        Observer(builder: (_) {
          return viewModel.isSearching
              ? const SizedBox()
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

  Widget getAppBarListTile(BuildContext context, ShopOwnerProductListViewModel viewModel) {
    return ListTile(
      title: TextFormField(
        textInputAction: TextInputAction.search,
        onChanged: (value) {},
        autofocus: true,
        onFieldSubmitted: (term) {
          viewModel.filterProducts(term);
        },
        decoration: buildInputDecoration(
          context,
          hintText: LocaleKeys.enterProductNameText.locale,
          suffixIcon: IconButton(
              icon: Icon(
                Icons.cancel_sharp,
                size: context.dynamicHeight(0.03),
                color: context.colorScheme.onSurfaceVariant,
              ),
              onPressed: () {
                viewModel.changeIsSearching();
              }),
        ),
      ),
    );
  }
}
