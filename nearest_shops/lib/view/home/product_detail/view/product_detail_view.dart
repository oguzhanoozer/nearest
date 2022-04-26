import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../../core/components/card/list_item_card.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../product/contstants/image_path.dart';
import '../../comment/view/product_comment_view.dart';
import '../model/product_detail_model.dart';
import '../viewmodel/product_detail_view_model.dart';

class ProductDetailView extends StatelessWidget {
  final ProductDetailModel productDetailModel;
  const ProductDetailView({Key? key, required this.productDetailModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductDetailViewModel>(
      viewModel: ProductDetailViewModel(),
      onModelReady: (model) {},
      onPageBuilder: (BuildContext context, ProductDetailViewModel viewmodel) =>
          buildScaffold(context, viewmodel),
    );
  }

  Scaffold buildScaffold(
      BuildContext context, ProductDetailViewModel viewModel) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildProductDetail(context, viewModel),
    );
  }

  Padding buildProductDetail(
      BuildContext context, ProductDetailViewModel viewModel) {
    return Padding(
      padding: context.paddingLow,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: productDetailModel.imageUrlList!.isEmpty
                  ? Image.asset(
                      ImagePaths.instance.hazelnut,
                      fit: BoxFit.fill,
                    )
                  : PageView.builder(
                      controller: PageController(),
                      itemCount: productDetailModel.imageUrlList!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: ListItemCard(
                            child: Image.network(
                                productDetailModel.imageUrlList![index],
                                fit: BoxFit.contain),
                            radius: context.normalValue,
                            borderSide: BorderSide(
                                color: context.colorScheme.onInverseSurface,
                                width: 0.5),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                          ),
                        );
                      },
                    ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: context.horizontalPaddingNormal,
              child: buildDetailColumn(context),
            ),
          ),
        ],
      ),
    );
  }

  Column buildDetailColumn(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildProductTitle(context),
            buildProductPrice(context),
          ],
        ),
        buildProductPoint(context),
        Expanded(
          child: Padding(
            padding: context.verticalPaddingNormal,
            child: buildProductBody(context),
          ),
        ),
      ],
    );
  }

  Column buildProductBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AutoSizeText(productDetailModel.detail.toString(),
              style: context.textTheme.headline6!),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NormalButton(
              child: Row(
                children: [
                  Icon(Icons.comment, color: context.colorScheme.onSecondary),
                  Text(
                   LocaleKeys.commentsText.locale,
                    style: context.textTheme.headline6!
                        .copyWith(color: context.colorScheme.onSecondary),
                  ),
                ],
              ),
              onPressed: () {
                context.navigateToPage(ProductCommentView(productDetailModel: productDetailModel,));
              },
              color: context.appTheme.colorScheme.onSurfaceVariant,
            ),
            NormalButton(
              child: Text(
                LocaleKeys.seeOurOtherProductsText.locale,
                style: context.textTheme.headline6!
                    .copyWith(color: context.colorScheme.onSecondary),
              ),
              onPressed: null,
              color: context.appTheme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ],
    );
  }

  Row buildProductPoint(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.star, color: context.colorScheme.inversePrimary),
        Text(
          "(4,5)",
          style: context.textTheme.bodyText2!.copyWith(
              color: context.colorScheme.inversePrimary,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Text buildProductPrice(BuildContext context) {
    return Text(
      productDetailModel.price.toString(),
      style: context.textTheme.headline5!.copyWith(
          color: context.colorScheme.primary, fontWeight: FontWeight.bold),
    );
  }

  Text buildProductTitle(BuildContext context) {
    return Text(
      productDetailModel.name.toString(),
      style: context.textTheme.headline6!.copyWith(
          color: context.colorScheme.primary, fontWeight: FontWeight.bold),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: context.horizontalPaddingLow,
        child: IconButton(
          icon: Icon(Icons.cancel),
          color: context.colorScheme.onPrimary,
          iconSize: context.dynamicHeight(0.03),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      actions: [
        Padding(
          padding: context.horizontalPaddingLow,
          child: IconButton(
            icon: Icon(Icons.favorite),
            color: context.colorScheme.onPrimary,
            iconSize: context.dynamicHeight(0.03),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
