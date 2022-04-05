import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
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

  Scaffold buildScaffold(BuildContext context, DashboardViewModel viewmodel) =>
      Scaffold(
        body: Observer(builder: (_) {
          return Padding(
            padding: context.paddingNormal,
            child: CustomScrollView(
              controller: viewmodel.controller,
              slivers: [
                buildSliverApp(context),
                SizedBox(
                  height: context.dynamicHeight(0.25),
                  child: viewmodel.isProductSliderListLoading
                      ? const Center(child: CircularProgressIndicator())
                      : DashboardAdsSlider(
                          viewmodel: viewmodel,
                          productSliderList: viewmodel.getProductSliderList(),
                          onlyImage: false),
                ).toSliver,
                buildCategoriesText(context).toSliver,
                //buildCategoriesTabBar(context).toSliver,
                buildCategoriesRow(context, viewmodel).toSliver,
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
        /*
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          onPressed: () async {
            await viewmodel.callFirestore();
          },
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  //update the bottom app bar view each time an item is clicked
                  onPressed: () {},
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.home,
                    //darken the icon if it is selected or else give it a different color
                    color: Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  iconSize: 27.0,
                  icon: Icon(Icons.category_outlined,
                      color: Colors.blue.shade900),
                ),
                //to leave space in between the bottom app bar items and below the FAB
                SizedBox(
                  width: 50.0,
                ),
                IconButton(
                  onPressed: () {},
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          //to add a space between the FAB and BottomAppBar
          shape: CircularNotchedRectangle(),
          //color of the BottomAppBar
          color: Colors.white,
        ),
        */
      );

  SliverAppBar buildSliverApp(BuildContext context) {
    return SliverAppBar(
        expandedHeight: context.height * 0.12,
        pinned: false,
        actions: [buildAppBarActionsContainer(context)],
        title: buildAppBarTitle(context),
        leading: IconButton(
            onPressed: () async {
              await FirebaseAuthentication.instance.signOut();
            },
            icon: Icon(Icons.logout)),
        flexibleSpace: buildFlexibleSpaceBar(context));
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTopCetegoriesText(context),
          buildSeeAllText(context),
        ],
      ),
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
    return SizedBox(
      height: context.height * 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "The Nearest",
            style: context.textTheme.headline5!.copyWith(
                color: context.appTheme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
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
}
