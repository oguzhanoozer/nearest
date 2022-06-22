import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/core/base/route/generate_route.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/base/model/product_detail_view_arg.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/extension/widget_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/circular_progress/circular_progress_indicator.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/grid/product_grid.dart';
import '../../../product/image/image_network.dart';
import '../../../product/input_text_decoration.dart';
import '../../../product/slider/dashboard_ads_slider.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../../product_detail/view/product_detail_view.dart';
import '../../user_profile/view/user_profile_view.dart';
import '../viewmodel/dashboard_view_model.dart';

part 'subview/dashboard_category_view.dart';

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      viewModel: DashboardViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, DashboardViewModel viewmodel) => buildScaffold(context, viewmodel),
    );
  }

  Widget buildScaffold(BuildContext context, DashboardViewModel viewmodel) => Scaffold(
        key: viewmodel.scaffoldState,
        body: Observer(builder: (_) {
          return Padding(
            padding: context.paddingNormal,
            child: CustomScrollView(
              controller: viewmodel.controller,
              slivers: [
                appBarRow(context, viewmodel).toSliver,
                SizedBox(
                        height: context.dynamicHeight(0.25),
                        child: viewmodel.isProductSliderListLoading
                            ? Padding(
                                padding: context.paddingNormal,
                                child: Shimmer.fromColors(
                                  baseColor: context.colorScheme.onTertiary,
                                  highlightColor: context.colorScheme.onTertiary,
                                  direction: ShimmerDirection.ltr,
                                  child: buildSliderShimmer(context),
                                ),
                              )
                            : DashboardAdsSlider(viewmodel: viewmodel, productSliderList: viewmodel.getProductSliderList(), onlyImage: false))
                    .toSliver,
                viewmodel.isProductFirstListLoading
                    ? buildProductShimmer(context).toSliver
                    : buildProductsGrid(context, viewmodel.productList, viewmodel).toSliver,
                if (viewmodel.isProductMoreListLoading == true)
                  Padding(padding: EdgeInsets.only(top: context.dynamicHeight(0.01), bottom: context.dynamicHeight(0.04)), child: CallCircularProgress(context))
                      .toSliver,
              ],
            ),
          );
        }),
      );
  final GlobalKey<PopupMenuButtonState<String>> _menuKey = GlobalKey();

  Widget appBarRow(BuildContext context, DashboardViewModel viewmodel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 7, child: buildAppBarTitle(context)),
            Expanded(flex: 1, child: buildAppBarProfileCircle(context)),
          ],
        ),
        context.emptySizedHeightBoxLow3x,
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: TypeAheadField<ProductDetailModel?>(
                  loadingBuilder: (context) {
                    return CallCircularProgress(context);
                  },
                  hideKeyboard: false,
                  debounceDuration: context.durationLow,

                  ///  hideSuggestionsOnKeyboardHide: false,
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: viewmodel.searcpInputTExtFieldController,
                    style: inputTextStyle(context),
                    autocorrect: false,
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: false,
                    textInputAction: TextInputAction.search,
                    decoration: buildInputDecoration(
                      context,
                      hintText: LocaleKeys.searchTheProductText.locale,
                    ),
                  ),
                  suggestionsCallback: viewmodel.filterProductList,

                  itemBuilder: (context, ProductDetailModel? suggestion) {
                    final product = suggestion!;

                    return ListTile(
                      leading: SizedBox(
                        height: context.dynamicHeight(0.2),
                        width: context.dynamicWidth(0.2),
                        child: product.imageUrlList!.isEmpty
                            ? Padding(padding: context.paddingLow, child: defaultProductImage(context, product.categoryId!))
                            : buildImageNetwork(product.imageUrlList!.first, context),
                      ),
                      title: Text(product.name.toString(), maxLines: 1, style: titleTextStyle(context)),
                      trailing: Text(product.summary.toString(), style: summaryTextStyle(context)),
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
                    bool currentFav = Navigator.pushNamed(context, productDetailViewRoute,
                        arguments: ProductDetailViewArguments(
                          productDetailModel,
                          checkProductInFavourite(viewmodel, productDetailModel),
                        )) as bool;

                    if (checkProductInFavourite(viewmodel, productDetailModel) != currentFav) {
                      await viewmodel.changeFavouriteList(productDetailModel.productId.toString());
                    }
                  },
                ),
              ),
              context.emptySizedWidthBoxLow3x,
              Expanded(
                flex: 1,
                child: buildOrderWidget(context, viewmodel),
              )
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector buildOrderWidget(BuildContext context, DashboardViewModel viewmodel) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        _showPopupMenu(context, details.globalPosition, viewmodel);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: context.normalBorderRadius / 2, color: context.colorScheme.onSurfaceVariant),
        child: Padding(
          padding: context.paddingLow,
          child: Image.asset(
            ImagePaths.instance.filter_white_512,
            fit: BoxFit.contain,
            height: context.dynamicHeight(0.04),
          ),
        ),
      ),
    );
  }

  _showPopupMenu(BuildContext context, Offset offset, DashboardViewModel viewmodel) async {
    double left = offset.dx;
    double top = offset.dy;

    await showMenu(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(context.normalRadius)),
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
            child: Row(
              children: [
                Icon(Icons.arrow_upward, color: context.colorScheme.onPrimary),
                context.emptySizedWidthBoxLow,
                Text(LocaleKeys.suggestedOrder.locale, style: titleTextStyle(context)),
              ],
            ),
            value: 0),
        PopupMenuDivider(height: 1),
        PopupMenuItem<int>(
            child: Row(
              children: [
                Icon(Icons.arrow_upward, color: context.colorScheme.onPrimary),
                context.emptySizedWidthBoxLow,
                Text(LocaleKeys.increasingPrice.locale, style: inputTextStyle(context)),
              ],
            ),
            value: 1),
        PopupMenuDivider(height: 1),
        PopupMenuItem<int>(
            child: Row(
              children: [
                Icon(Icons.arrow_downward, color: context.colorScheme.onPrimary),
                context.emptySizedWidthBoxLow,
                Text(LocaleKeys.decreasingPrice.locale, style: inputTextStyle(context)),
              ],
            ),
            value: 2),
      ],
    ).then((itemSelected) {
      if (itemSelected == null) {
        return;
      } else if (itemSelected == 0) {
        viewmodel.sortProductList(Sorting.SUGGEST_ORDER);
      } else if (itemSelected == 1) {
        viewmodel.sortProductList(Sorting.DECREASE_PRICE);
      } else if (itemSelected == 2) {
        viewmodel.sortProductList(Sorting.INCREASE_PRICE);
      }
    });
  }

  Widget buildAppBarProfileCircle(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, userProfileViewRoute);
      },
      child: Container(
        height: context.highValue / 1.7,
        width: context.highValue / 1.7,
        child: Icon(
          Icons.person,
          color: context.colorScheme.primary,
          size: context.highValue / 2,
        ),
        decoration: BoxDecoration(
          border: Border.all(width: context.lowValue / 15, color: context.colorScheme.primary),
          shape: BoxShape.circle,
          color: context.colorScheme.background,
        ),
      ),
    );
  }

  Widget buildAppBarTitle(BuildContext context) {
    return Text(LocaleKeys.TheNearestBigTitle.locale,
        style: GoogleFonts.concertOne(
            textStyle: context.textTheme.headline4!.copyWith(color: context.appTheme.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold)));
  }

  Widget buildProductsGrid(BuildContext context, List<ProductDetailModel> productDetailList, DashboardViewModel viewModel) {
    return ProductGrid(productList: productDetailList, dashboardViewModel: viewModel);
  }

  bool checkProductInFavourite(DashboardViewModel? dashboardViewModel, ProductDetailModel productDetailModel) {
    return dashboardViewModel!.userFavouriteList.contains(productDetailModel.productId);
  }
}
