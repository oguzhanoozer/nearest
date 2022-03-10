import 'package:json_annotation/json_annotation.dart';

part 'dashboard_ads_slider_model.g.dart';

@JsonSerializable()
class DashboardAdsSliderModel {
  final String? url;

  DashboardAdsSliderModel({this.url});

  @override
  DashboardAdsSliderModel fromJson(Map<String, Object?> json) {
    return _$DashboardAdsSliderModelFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$DashboardAdsSliderModelToJson(this);
  }

}
