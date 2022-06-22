part of '../dashboard_view.dart';

extension _DashboardProductsWidgets on DashboardView {
  Shimmer buildProductShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.onTertiary,
      highlightColor: context.colorScheme.onTertiary,
      direction: ShimmerDirection.ltr,
      child: buildGridViewShimmer(),
    );
  }

  GridView buildGridViewShimmer() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(padding: context.paddingLow, child: buildShimmerColumn(context)),
    );
  }

  Column buildShimmerColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Container(
            width: double.infinity,
            child: Card(
              color: context.colorScheme.inversePrimary,
            ),
          ),
        ),
        context.emptySizedHeightBoxLow,
        buildShimmerContainer(context, 0.4),
        context.emptySizedHeightBoxLow,
        buildShimmerContainer(context, 0.3),
        context.emptySizedHeightBoxLow,
        builderShimmerRow(context),
      ],
    );
  }

  Expanded builderShimmerRow(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Card(
              color: context.colorScheme.inversePrimary,
              child: Container(),
            ),
          ),
          Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: Icon(Icons.favorite)))
        ],
      ),
    );
  }

  Expanded buildShimmerContainer(BuildContext context, double height) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        width: context.dynamicWidth(height),
        child: Card(
          color: context.colorScheme.inversePrimary,
        ),
      ),
    );
  }

  Row buildSliderShimmer(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: context.paddingNormal,
            child: Card(
              color: context.colorScheme.inversePrimary,
              child: Container(),
            ),
          ),
        ),
        context.emptySizedWidthBoxLow3x,
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              context.emptySizedHeightBoxLow3x,
              buildShimmerContainer(context, 0.5),
              context.emptySizedHeightBoxLow,
              buildShimmerContainer(context, 0.3),
              context.emptySizedHeightBoxLow,
              buildShimmerContainer(context, 0.2),
              context.emptySizedHeightBoxLow,
              builderShimmerRow(context),
              context.emptySizedHeightBoxLow3x,
            ],
          ),
        )
      ],
    );
  }
}
