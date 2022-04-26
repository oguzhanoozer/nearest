import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/extension/widget_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/authenticaion/firebase_authentication.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/grid/product_grid.dart';
import '../../../product/slider/dashboard_ads_slider.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../../user_profile/view/user_profile_view.dart';
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
                appBarRow(context, viewmodel).toSliver,
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
                ////buildCategoriesText(context).toSliver,
                viewmodel.isProductFirstListLoading
                    ? const Center(child: CircularProgressIndicator()).toSliver
                    : buildProductsGrid(
                            context, viewmodel.productList, viewmodel)
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

  Widget appBarRow(BuildContext context, DashboardViewModel viewmodel) {
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
                icon: const Icon(Icons.logout)),
            buildAppBarTitle(context),
            buildAppBarActionsContainer(context)
          ],
        ),
        Center(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            onChanged: (value) {
              if (value.isEmpty) {
              viewmodel.filterProducts("");
              }
            },
            validator: (value) => null,
            obscureText: false,
            onFieldSubmitted: (term) {
              viewmodel.filterProducts(term);
            },
            textInputAction: TextInputAction.search,
            decoration: buildInputDecoration(context),
          ),
        ),
      ], 
    );
  }

  Widget buildAppBarActionsContainer(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateToPage(UserProfileView());
      },
      child: Container(
        height: context.mediumValue,
        width: context.mediumValue,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(ImagePaths.instance.profile), fit: BoxFit.fill),
        ),
      ),
    );
  }

  Widget buildAppBarTitle(BuildContext context) {
    return Text(
      LocaleKeys.theNearestText.locale,
      style: context.textTheme.headline5!.copyWith(
          color: context.appTheme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.bold),
    );
  }

  Widget buildProductsGrid(
      BuildContext context,
      List<ProductDetailModel> productDetailList,
      DashboardViewModel viewModel) {
    return ProductGrid(
        productList: productDetailList, dashboardViewModel: viewModel);
  }
}
