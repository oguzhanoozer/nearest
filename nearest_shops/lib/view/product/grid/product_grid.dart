import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../home/dashboard/model/dashboard_model.dart';

class ProductGrid extends StatelessWidget {
  final List<DashboardModel>? dashboardModel;

  const ProductGrid({Key? key, this.dashboardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
      ),
      itemCount: dashboardModel!.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: context.paddingLow,
        child: buildProductCard(context, index),
      ),
    );
  }

  Card buildProductCard(BuildContext context, int index) {
    return Card(
      color: context.colorScheme.onInverseSurface,
      shape: RoundedRectangleBorder(
        side:
            BorderSide(color: context.colorScheme.onInverseSurface, width: 0.5),
        borderRadius: BorderRadius.circular(context.normalValue),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: buildProductImage(index),
          ),
          Expanded(
            flex: 3,
            child: buildProductDetail(context, index),
          ),
        ],
      ),
    );
  }

  Padding buildProductDetail(BuildContext context, int index) {
    return Padding(
      padding: context.paddingLow / 2,
      child: Container(
        decoration: BoxDecoration(
            color: context.colorScheme.onSecondary,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(context.normalValue),
                bottomRight: Radius.circular(context.normalValue))),
        child: Column(
          ///  mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              dashboardModel![index].title ?? "",
              textAlign: TextAlign.center,
              style: context.textTheme.headline6,
            ),
            Text(
              dashboardModel![index].body ?? "",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  dashboardModel![index].price ?? "",
                  style: context.textTheme.headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.shopping_bag),
              ],
            )
          ],
        ),
      ),
    );
  }

  Center buildProductImage(int index) {
    return Center(
      child: Image.asset(dashboardModel![index].url ?? ""),
    );
  }
}
