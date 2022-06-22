import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/model/product_detail_view_arg.dart';
import '../../../../core/base/route/generate_route.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/card/list_item_card.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/grid/product_grid.dart';
import '../../../product/image/image_network.dart';
import '../../../product/input_text_decoration.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../../product_detail/view/product_detail_view.dart';
import '../viewModel/categories_view_model.dart';

part 'subview/categories_extension.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoriesViewModel>(
      viewModel: CategoriesViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, CategoriesViewModel viewModel) => buildScaffold(context, viewModel),
    );
  }

  Widget buildScaffold(BuildContext context, CategoriesViewModel viewmodel) => Scaffold(
        appBar: buildAppBar(context, viewmodel),
        body: Observer(builder: (_) {
          return Padding(
              padding: context.horizontalPaddingNormal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Observer(builder: (_) {
                    return buildCategoriesRow(context, viewmodel);
                  }),
                  context.emptySizedHeightBoxLow,
                  viewmodel.isProductFirstListLoading
                      ? Column(
                          children: [
                            context.emptySizedHeightBoxHigh,
                            CallCircularProgress(context),
                          ],
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                          child: buildProductsGrid(context, viewmodel.productList, viewmodel),
                        )),
                  if (viewmodel.isProductMoreListLoading == true)
                    Padding(
                        padding: EdgeInsets.only(top: context.dynamicHeight(0.01), bottom: context.dynamicHeight(0.04)), child: CallCircularProgress(context)),
                ],
              ));
        }),
      );

  Widget buildProductsGrid(BuildContext context, List<ProductDetailModel> productDetailList, CategoriesViewModel viewModel) {
    return ProductGrid(productList: productDetailList, categoriesViewModel: viewModel);
  }

  AppBar buildAppBar(BuildContext context, CategoriesViewModel viewModel) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Observer(builder: (_) {
        return viewModel.isSearching
            ? getAppBarListTile(context, viewModel)
            : Text(
                LocaleKeys.topCategoriesText.locale,
                style: GoogleFonts.concertOne(
                    textStyle: context.textTheme.headline5!.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                )),
              );
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
                    icon: Icon(
                      Icons.search,
                      size: context.dynamicHeight(0.03),
                    ),
                  ),
                );
        })
      ],
    );
  }

  Widget getAppBarListTile(BuildContext context, CategoriesViewModel viewModel) {
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
                  ? Padding(padding: context.paddingLow, child: defaultProductImage(context, product.categoryId!))
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
          child: Text(LocaleKeys.anyProductFound.locale, style: inputTextStyle(context)),
        ),
      ),
      onSuggestionSelected: (ProductDetailModel? suggestion) async {
        final productDetailModel = suggestion!;

        bool currentFav = await Navigator.pushNamed(context, productDetailViewRoute,
            arguments: ProductDetailViewArguments(
              productDetailModel,
              checkProductInFavourite(viewModel, productDetailModel),
            )) as bool;

        if (checkProductInFavourite(viewModel, productDetailModel) != currentFav) {
          await viewModel.changeFavouriteList(productDetailModel.productId.toString());
        }
      },
    ));
  }

  bool checkProductInFavourite(CategoriesViewModel? categoriesViewModel, ProductDetailModel productDetailModel) {
    return categoriesViewModel!.userFavouriteList.contains(productDetailModel.productId);
  }
}
