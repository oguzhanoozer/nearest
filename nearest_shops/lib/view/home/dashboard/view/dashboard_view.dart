import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/extension/widget_extension.dart';
import '../../../../core/init/service/firebase_authentication.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/grid/product_grid.dart';
import '../../../product/slider/dashboard_ads_slider.dart';
import '../viewmodel/dashboard_view_model.dart';

part 'subview/dashboard_category_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      viewModel: DashboardViewModel(),
      onModelReady: (model) {},
      onPageBuilder: (BuildContext context, DashboardViewModel viewmodel) =>
          buildScaffold(context, viewmodel),
    );
  }

  Scaffold buildScaffold(BuildContext context, DashboardViewModel viewmodel) =>
      Scaffold(
        body: Padding(
          padding: context.paddingNormal,
          child: CustomScrollView(
            slivers: [
              buildSliverApp(context),
              SizedBox(
                height: context.dynamicHeight(0.25),
                child: DashboardAdsSlider(
                    dashboardModelList: viewmodel.dashboardModelList,
                    onlyImage: false),
              ).toSliver,
              buildCategoriesText(context).toSliver,
              //buildCategoriesTabBar(context).toSliver,
              buildCategoriesRow(context).toSliver,
              buildProductsGrid(context, viewmodel).toSliver,
            ],
          ),
        ),
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
      );

  SliverAppBar buildSliverApp(BuildContext context) {
    return SliverAppBar(
        expandedHeight: context.height * 0.18,
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
    DashboardViewModel viewModel,
  ) {
    return ProductGrid(
      dashboardModel: viewModel.dashboardModelList,
    );
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
      style: context.textTheme.headline5!.copyWith(
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
            "Hey Oğuzhan",
            style: context.textTheme.headline5,
          ),
          Text("What you need to buy ?")
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
