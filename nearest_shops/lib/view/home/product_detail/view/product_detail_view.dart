import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/model/product_detail_view_arg.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/column/form_column.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/image/image_network.dart';
import '../../../product/input_text_decoration.dart';
import '../../../product/slider/circle_indicator_list.dart';
import '../../comment/view/product_comment_view.dart';
import '../model/product_detail_model.dart';
import '../viewmodel/product_detail_view_model.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailViewArguments productDetailViewArguments;

   ProductDetailView({
    Key? key,
    required this.productDetailViewArguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductDetailViewModel>(
      viewModel: ProductDetailViewModel(),
      onModelReady: (model) {
        model.init();
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, ProductDetailViewModel viewmodel) => buildScaffold(context, viewmodel),
    );
  }

  Widget buildScaffold(BuildContext context, ProductDetailViewModel viewModel) {
    if (viewModel.isPopFalse == false) {
      viewModel.setCurrentFavourite(productDetailViewArguments.isFavourite);
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, viewModel.isCurrentFavurite);
        return false;
      },
      child: Scaffold(
        key: viewModel.scaffoldState,
        body: buildProductDetail(context, viewModel),
      ),
    );
  }

  Widget buildProductDetail(BuildContext context, ProductDetailViewModel viewModel) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: SizedBox(
            height: context.dynamicHeight(0.5),
            child: productDetailViewArguments.productDetailModel.imageUrlList!.isEmpty
                ? Image.asset(
                    ImagePaths.instance.hazelnut,
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  )
                : PageView.builder(
                    onPageChanged: viewModel.onChanged,
                    controller: PageController(),
                    itemCount: productDetailViewArguments.productDetailModel.imageUrlList!.length,
                    itemBuilder: (context, index) {
                      return buildImageNetwork(productDetailViewArguments.productDetailModel.imageUrlList![index], context);
                    },
                  ),
          ),
        ),
        Positioned(
          top: context.dynamicHeight(0.01),
          right: context.dynamicWidth(0.05),
          child: CircleAvatar(
              backgroundColor: context.colorScheme.inversePrimary,
              child: Observer(builder: (_) {
                return IconButton(
                  icon: const Icon(Icons.favorite),
                  color: viewModel.isCurrentFavurite! ? context.colorScheme.onSurfaceVariant : context.colorScheme.surface,
                  onPressed: () {
                    viewModel.changeCurrentFavourite();
                  },
                );
              })),
        ),
        Positioned(
          top: context.dynamicHeight(0.01),
          left: context.dynamicWidth(0.05),
          child: CircleAvatar(
            backgroundColor: context.colorScheme.inversePrimary,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, viewModel.isCurrentFavurite);
              },
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Positioned(
          top: context.dynamicHeight(0.38),
          right: context.dynamicWidth(0.5),
          child: Observer(builder: (_) {
            return Container(
              height: context.normalValue,
              child: BuildCircleIndicator(currentIndex: viewModel.selectedCurrentIndex, length: productDetailViewArguments.productDetailModel.imageUrlList!.length, isDetailPage: true),
            );
          }),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: context.dynamicHeight(0.55),
          child: Container(
            decoration: BoxDecoration(
              color: context.colorScheme.onSecondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.mediumValue),
                topRight: Radius.circular(context.mediumValue),
              ),
            ),
            child: buildDetailColumn(context, viewModel),
          ),
        )
      ],
    );
  }

  Widget buildDetailColumn(BuildContext context, ProductDetailViewModel viewModel) {
    return FormColumn(
      children: [
        context.emptySizedHeightBoxLow,
        buildProductTitle(context),
        buildProductSummary(context),
        context.emptySizedHeightBoxLow,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.onSurfaceVariant,
                borderRadius: BorderRadius.circular(
                  context.lowValue,
                ),
              ),
              child: Padding(
                padding: context.paddingLow / 2,
                child: Text(
                  productDetailViewArguments.productDetailModel.categoryTitle ?? "",
                  style: GoogleFonts.lora(textStyle: context.textTheme.bodyText1!.copyWith(color: context.colorScheme.inversePrimary)),
                ),
              ),
            ),
            context.emptySizedWidthBoxLow3x,
            buildProductPrice(context),
          ],
        ),
        context.emptySizedHeightBoxLow,
        buildProductAbout(context),
        context.emptySizedHeightBoxLow,
        Expanded(
          child: buildProductBody(context, viewModel),
        ),
      ],
    );
  }

  Column buildProductBody(BuildContext context, ProductDetailViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SingleChildScrollView(child: AutoSizeText(productDetailViewArguments.productDetailModel.detail.toString(), style: summaryTextStyle(context))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: NormalButton(
                child: Row(
                  children: [
                    Icon(Icons.comment, color: context.colorScheme.inversePrimary),
                    context.emptySizedWidthBoxLow3x,
                    Text(
                      LocaleKeys.commentsText.locale,
                      style: GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(color: context.colorScheme.inversePrimary)),
                    ),
                  ],
                ),
                onPressed: () {
                  context.navigateToPage(ProductCommentView(
                    productDetailModel: productDetailViewArguments.productDetailModel,
                  ));
                },
                color: context.appTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            context.emptySizedWidthBoxLow3x,
            Expanded(
              child: NormalButton(
                child: Text(
                  LocaleKeys.seeOurOtherProductsText.locale,
                  style: GoogleFonts.lora(textStyle: context.textTheme.headline6!.copyWith(color: context.colorScheme.inversePrimary)),
                ),
                onPressed: () async {
                  await viewModel.pushToShopsMap(context, productDetailViewArguments.productDetailModel.shopId.toString());
                },
                color: context.appTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildProductPrice(BuildContext context) {
    return FittedBox(
      child: Text(productDetailViewArguments.productDetailModel.price.toString(), style: priceTextStyle(context)),
    );
  }

  Widget buildProductTitle(BuildContext context) {
    return FittedBox(
      child: Text(productDetailViewArguments.productDetailModel.name.toString(), maxLines: 1, style: titleTextStyle(context, fontsize: 20)),
    );
  }

  Widget buildProductAbout(BuildContext context) {
    return Text(LocaleKeys.aboutProduct.locale, style: titleTextStyle(context, fontsize: 20));
  }

  Widget buildProductSummary(BuildContext context) {
    return Text(productDetailViewArguments.productDetailModel.summary.toString(), maxLines: 2, style: summaryTextStyle(context));
  }

  AppBar buildAppBar(BuildContext context, ProductDetailViewModel viewModel) {
    return AppBar(
      leading: Padding(
        padding: context.horizontalPaddingLow,
        child: IconButton(
          icon: const Icon(Icons.cancel),
          color: context.colorScheme.onSurfaceVariant,
          iconSize: context.dynamicHeight(0.04),
          onPressed: () {
            Navigator.pop(context, viewModel.isCurrentFavurite);
          },
        ),
      ),
      actions: [
        Observer(builder: (_) {
          return Padding(
            padding: context.horizontalPaddingLow,
            child: IconButton(
              icon: const Icon(Icons.favorite),
              color: viewModel.isCurrentFavurite! ? context.colorScheme.onPrimaryContainer : context.colorScheme.surface,
              iconSize: context.dynamicHeight(0.04),
              onPressed: () {
                viewModel.changeCurrentFavourite();
              },
            ),
          );
        })
      ],
    );
  }
}
