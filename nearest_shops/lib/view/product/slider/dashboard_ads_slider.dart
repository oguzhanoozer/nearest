import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../home/dashboard/model/dashboard_model.dart';
import '../../home/dashboard/viewmodel/dashboard_view_model.dart';
import '../../home/product_detail/model/product_detail_model.dart';
import 'circle_indicator_list.dart';
import 'slider_card.dart';

class DashboardAdsSlider extends StatefulWidget {
  final List<ProductDetailModel>? productSliderList;
  final bool onlyImage;
  final DashboardViewModel viewmodel;

  DashboardAdsSlider(
      {Key? key, this.productSliderList, required this.onlyImage,required this.viewmodel})
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
          child: buildImagePageView(_selectedCurrentIndex,widget.viewmodel),
        ),
        Expanded(
          flex: 1,
          child: BuildCircleIndicator(
              currentIndex: _selectedCurrentIndex,
              length: widget.productSliderList!.length),
        )
      ],
    );
  }

  PageView buildImagePageView(int _selectedCurrentIndex, DashboardViewModel viewmodel) {
    return PageView.builder(
      onPageChanged: _onChanged,
      controller: PageController(),
      itemCount: widget.productSliderList!.length,
      itemBuilder: (context, index) {
        return buildImageNetwork(context, index,viewmodel);
      },
    );
  }
/*
  Widget buildImageListView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.productSliderList!.length,
        itemBuilder: (context, index) {
          return buildImageNetwork(context, index);
        });
  }
  */

  void _onChanged(int index) {
    _selectedCurrentIndex = index;
    setState(() {});
  }

  Widget buildImageNetwork(BuildContext context, int index, DashboardViewModel viewmodel) {
    return Padding(
      padding: context.paddingNormal,
      child: SliderCard(
          productDetailModel: widget.productSliderList![index],
          context: context,
          onlyImage: widget.onlyImage,viewmodel:viewmodel ),
    );
  }
}
