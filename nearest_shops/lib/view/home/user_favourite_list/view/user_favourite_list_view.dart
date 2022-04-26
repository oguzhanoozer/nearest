import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../../../product/product_list_view/product_list_view.dart';
import '../../product_detail/view/product_detail_view.dart';
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
        appBar: buildAppBar(context, viewModel),
        body: buildBody(viewModel, context),
      );

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
            child: Text(LocaleKeys.favouriteListEmptyText.locale),
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
    return GestureDetector(
      onTap: (() => context.navigateToPage(ProductDetailView(
            productDetailModel: productDetailModel,
          ))),
      child: ProductListView(
        productDetailModel: productDetailModel,
        shopModel: null,
        rightSideWidget: IconButton(
          iconSize: 30,
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.delete,
            color: context.colorScheme.onPrimaryContainer,
          ),
          onPressed: () async {
            await viewModel.removeFavouriteItem(index);
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(
      BuildContext context, UserFavouriteListViewModel viewModel) {
    return AppBar(
      elevation: 0.1,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Observer(builder: (_) {
        return viewModel.isSearching
            ? getAppBarListTile(context, viewModel)
            : Text(LocaleKeys.yourSavedProductsText.locale,
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
      BuildContext context, UserFavouriteListViewModel viewModel) {
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
