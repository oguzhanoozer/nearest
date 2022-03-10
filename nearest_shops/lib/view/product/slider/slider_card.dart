import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../home/dashboard/model/dashboard_model.dart';

class SliderCard extends Card {
  final BuildContext context;
  final DashboardModel dashboardModel;
  final bool onlyImage;

  SliderCard({
    required this.dashboardModel,
    required this.context,
    required this.onlyImage,
  }) : super(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(width: 1, color: Colors.orange[100]!)),
          child: Padding(
            padding: context.paddingNormal,
            child: Row(
              children: [
                Expanded(
                  //child: Image.network(widget.dashboardModelList![index].url ?? "",
                  child: buildProductImage(dashboardModel),
                ),
                onlyImage
                    ? Container()
                    : Expanded(
                        child: buildProductDetail(dashboardModel, context),
                      ),
              ],
            ),
          ),
        );

  static Column buildProductDetail(
      DashboardModel dashboardModel, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildProductTitle(dashboardModel, context),
        buildProductBody(dashboardModel),
        SizedBox(height: 20),
        buildProductPriceRow(dashboardModel, context),
      ],
    );
  }

  static Row buildProductPriceRow(
      DashboardModel dashboardModel, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          dashboardModel.price ?? "",
          style: context.textTheme.headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Icon(Icons.shopping_bag),
      ],
    );
  }

  static Text buildProductBody(DashboardModel dashboardModel) =>
      Text(dashboardModel.body ?? "");

  static Text buildProductTitle(
      DashboardModel dashboardModel, BuildContext context) {
    return Text(
      dashboardModel.title ?? "",
      style: context.textTheme.headline4!
          .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  static Image buildProductImage(DashboardModel dashboardModel) {
    return Image.asset(dashboardModel.url ?? "", fit: BoxFit.fill);
  }
}
