
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/product_detail_view_arg.dart';
import '../../../../core/base/route/generate_route.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../home/product_detail/model/product_detail_model.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/image/image_network.dart';
import '../../../product/input_text_decoration.dart';
import '../../../product/shop_product_view/product_list_view.dart';
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
      onPageBuilder: (context, UserFavouriteListViewModel viewModel) => buildScaffold(viewModel, context),
    );
  }

  Scaffold buildScaffold(UserFavouriteListViewModel viewModel, BuildContext context) => Scaffold(
        key: viewModel.scaffoldState,
        appBar: buildAppBar(context, viewModel),
        body: buildBody(viewModel, context),
      );

  Widget buildBody(UserFavouriteListViewModel viewModel, BuildContext context) => Observer(builder: (_) {
        return viewModel.isProductListLoading
            ? CallCircularProgress(context)
            : Column(
                children: [
                  Expanded(child: showProductList(viewModel.favouriteProductList, viewModel, context)),
                ],
              );
      });

  Widget showProductList(ObservableList<ProductDetailModel> productList, UserFavouriteListViewModel viewModel, BuildContext context) {
    return productList.isEmpty
        ? Center(
            child: Text(
              LocaleKeys.favouriteListEmptyText.locale,
              style: titleTextStyle(context),
            ),
          )
        : Padding(
            padding: context.paddingNormal,
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return buildProductCard(context, productList[index], viewModel, index);
              },
            ),
          );
  }

  Widget buildProductCard(BuildContext context, ProductDetailModel productDetailModel, UserFavouriteListViewModel viewModel, int index) {
    return GestureDetector(
      onTap: () async {
        bool currentFav = Navigator.pushNamed(context, productDetailViewRoute, arguments: ProductDetailViewArguments(productDetailModel, true)) as bool;

        if (currentFav == false) {
          await viewModel.removeFavouriteItem(index);
        }
      },
      child: ShopProductView(
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

  AppBar buildAppBar(BuildContext context, UserFavouriteListViewModel viewModel) {
    return AppBar(
      elevation: 0.1,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Observer(builder: (_) {
        return viewModel.isSearching
            ? getAppBarListTile(context, viewModel)
            : Text(LocaleKeys.yourSavedProductsText.locale,
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
                    icon: Icon(Icons.search, size: context.dynamicHeight(0.03)),
                  ),
                );
        })
      ],
    );
  }

  Widget getAppBarListTile(BuildContext context, UserFavouriteListViewModel viewModel) {
    return ListTile(
        title: TypeAheadField<ProductDetailModel?>(
      hideKeyboard: false,
      debounceDuration: context.durationLow,
      hideSuggestionsOnKeyboardHide: false,
      textFieldConfiguration: TextFieldConfiguration(
        style: inputTextStyle(context),
        textInputAction: TextInputAction.search,
        onChanged: (value) {},
        autofocus: true,
        decoration: buildInputDecoration(
          context,
          hintText: LocaleKeys.searchTheProductText.locale,
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
      suggestionsCallback: viewModel.filterProductList,
      itemBuilder: (context, ProductDetailModel? suggestion) {
        final ProductDetailModel product = suggestion!;

        return Container(
          color: context.colorScheme.onSecondary,
          child: ListTile(
            leading: SizedBox(
              height: context.dynamicHeight(0.1),
              width: context.dynamicWidth(0.1),
              child: product.imageUrlList!.isEmpty
                  ? Padding(
                      padding: context.paddingLow,
                      child:   defaultProductImage(context, product.categoryId!)
                    )
                  : buildImageNetwork(product.imageUrlList!.first, context),
            ),
            title: Text(product.name.toString(), style: titleTextStyle(context)),
            trailing: Text(product.summary.toString(), style: summaryTextStyle(context)),
          ),
        );
      },
      noItemsFoundBuilder: (context) => Container(
        height: context.dynamicHeight(0.1),
        width: context.dynamicWidth(1),
        color: context.colorScheme.onSecondary,
        child: Center(
          child: Text(LocaleKeys.anyProductFound.locale, style: titleTextStyle(context)),
        ),
      ),
      onSuggestionSelected: (ProductDetailModel? suggestion) async {
        final productDetailModel = suggestion!;

        bool currentFav = Navigator.pushNamed(context, productDetailViewRoute, arguments: ProductDetailViewArguments(productDetailModel, true)) as bool;

        if (!currentFav) {
          await viewModel.removeFromFavouriteList(productDetailModel);
        }
      },
    ));
  }
}
