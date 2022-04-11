import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/card/list_item_card.dart';
import '../../../../core/extension/widget_extension.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/grid/product_grid.dart';
import '../../../product/slider/dashboard_ads_slider.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../viewmodel/dashboard_view_model.dart';

part 'subview/dashboard_category_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      viewModel: DashboardViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, DashboardViewModel viewmodel) =>
          buildScaffold(context, viewmodel),
    );
  }

  Widget buildScaffold(BuildContext context, DashboardViewModel viewmodel) =>
      Scaffold(
        body: Observer(builder: (_) {
          return Padding(
            padding: context.paddingNormal,
            child: CustomScrollView(
              controller: viewmodel.controller,
              slivers: [
                appBarRow(context).toSliver,
                SizedBox(
                        height: context.dynamicHeight(0.25),
                        child: viewmodel.isProductSliderListLoading
                            ? const Center(child: CircularProgressIndicator())
                            : DashboardAdsSlider(
                                viewmodel: viewmodel,
                                productSliderList:
                                    viewmodel.getProductSliderList(),
                                onlyImage: false))
                    .toSliver,
                buildCategoriesText(context).toSliver,

                ///buildCategoriesRow(context, viewmodel).toSliver,
                buildCategoriesSliver(context, viewmodel),
                viewmodel.isProductFirstListLoading
                    ? const Center(child: CircularProgressIndicator()).toSliver
                    : buildProductsGrid(
                            context, viewmodel.getProductList(), viewmodel)
                        .toSliver,
                if (viewmodel.isProductMoreListLoading == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ).toSliver,
              ],
            ),
          );
        }),
      );

  SliverAppBar buildCategoriesSliver(
      BuildContext context, DashboardViewModel viewmodel) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      forceElevated: false,
      //  expandedHeight: context.height * 0.12,
      pinned: true,
      title: buildCategoriesRow(context, viewmodel),
      centerTitle: false,
    );
  }

  Widget appBarRow(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuthentication.instance.signOut();
                },
                icon: Icon(Icons.logout)),
            buildAppBarTitle(context),
            buildAppBarActionsContainer(context)
          ],
        ),
        Center(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            //textAlign: TextAlign.center,
            validator: (value) => null,
            obscureText: false,
            decoration: buildInputDecoration(context),
          ),
        ),
      ],
    );
  }

  Container buildAppBarActionsContainer(BuildContext context) {
    return Container(
      height: context.mediumValue,
      width: context.mediumValue,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage(ImagePaths.instance.profile), fit: BoxFit.fill),
      ),
    );
  }

  Widget buildAppBarTitle(BuildContext context) {
    return Text(
      "The Nearest",
      style: context.textTheme.headline5!.copyWith(
          color: context.appTheme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.bold),
    );
  }

  FlexibleSpaceBar buildFlexibleSpaceBar(BuildContext context) {
    return FlexibleSpaceBar(
      titlePadding: context.paddingLow,
      title: SizedBox(
        height: context.dynamicHeight(0.03),
        child: Center(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            //textAlign: TextAlign.center,
            validator: (value) => null,
            obscureText: false,
            decoration: buildInputDecoration(context),
          ),
        ),
      ),
    );
  }

  Widget buildProductsGrid(
      BuildContext context,
      List<ProductDetailModel> productDetailList,
      DashboardViewModel viewModel) {
    return ProductGrid(productList: productDetailList, viewModel: viewModel);
  }

  Widget buildCategoriesText(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingNormal,
      child: buildTopCetegoriesText(context),
    );
  }

  Text buildSeeAllText(BuildContext context) {
    return Text(
      "SEE ALL",
      style: context.textTheme.headline6!.copyWith(
          fontWeight: FontWeight.w500,
          color: context.colorScheme.onSurfaceVariant),
    );
  }

  Text buildTopCetegoriesText(BuildContext context) {
    return Text(
      "Top Categories",
      style: context.textTheme.headline6!.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.primary,
      ),
    );
  }
}
