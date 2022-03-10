import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/normal_button.dart';
import '../../../product/slider/dashboard_ads_slider.dart';
import '../viewmodel/product_detail_view_model.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({Key? key}) : super(key: key);

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
              child: DashboardAdsSlider(
                dashboardModelList: viewModel.dashboardModelList,
                onlyImage: true,
              )),
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
      children: [
        Expanded(
          child: AutoSizeText(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry." +
                  " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s," +
                  " when an unknown printer took a galley of type and scrambled it to make a type specimen book." +
                  "It has survived not only five centuries, but also the leap into electronic typesetting, " +
                  "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: context.textTheme.headline6!),
        ),
        NormalButton(
          child: Text(
            "See our other products",
            style: context.textTheme.headline6!
                .copyWith(color: context.colorScheme.onSecondary),
          ),
          onPressed: null,
          color: context.appTheme.colorScheme.onSurfaceVariant,
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
      "\$250",
      style: context.textTheme.headline5!.copyWith(
          color: context.colorScheme.primary, fontWeight: FontWeight.bold),
    );
  }

  Text buildProductTitle(BuildContext context) {
    return Text(
      "Car Cleaner",
      style: context.textTheme.headline6!.copyWith(
          color: context.colorScheme.primary, fontWeight: FontWeight.bold),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: context.horizontalPaddingLow,
        child: Icon(
          Icons.cancel,
          color: context.colorScheme.onPrimary,
          size: context.dynamicHeight(0.03),
        ),
      ),
      actions: [
        Padding(
          padding: context.horizontalPaddingLow,
          child: Icon(
            Icons.favorite,
            color: context.colorScheme.onPrimary,
            size: context.dynamicHeight(0.03),
          ),
        )
      ],
    );
  }
}
