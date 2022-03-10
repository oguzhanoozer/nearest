import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'slider_card.dart';

import '../../home/dashboard/model/dashboard_ads_slider_model.dart';
import '../../home/dashboard/model/dashboard_model.dart';
import 'circle_indicator_list.dart';

class DashboardAdsSlider extends StatefulWidget {
  final List<DashboardModel>? dashboardModelList;
  final bool onlyImage;

  DashboardAdsSlider(
      {Key? key, this.dashboardModelList, required this.onlyImage})
      : super(key: key);

  @override
  State<DashboardAdsSlider> createState() => _DashboardAdsSliderState();
}

class _DashboardAdsSliderState extends State<DashboardAdsSlider> {
  int _selectedCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: buildImagePageView(_selectedCurrentIndex),
        ),
        Expanded(
          flex: 1,
          child: BuildCircleIndicator(
              currentIndex: _selectedCurrentIndex,
              length: widget.dashboardModelList!.length),
        )
      ],
    );
  }

  PageView buildImagePageView(int _selectedCurrentIndex) {
    return PageView.builder(
      onPageChanged: _onChanged,
      controller: PageController(),
      itemCount: widget.dashboardModelList!.length,
      itemBuilder: (context, index) {
        return buildImageNetwork(context, index);
      },
    );
  }

  Widget buildImageListView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.dashboardModelList!.length,
        itemBuilder: (context, index) {
          return buildImageNetwork(context, index);
        });
  }

  void _onChanged(int index) {
    _selectedCurrentIndex = index;
    setState(() {});
  }

  Widget buildImageNetwork(BuildContext context, int index) {
    return Padding(
        padding: context.paddingNormal,
        child: SliderCard(
            dashboardModel: widget.dashboardModelList![index],
            context: context,
            onlyImage: widget.onlyImage));
  }
}
