import 'package:json_annotation/json_annotation.dart';

part 'dashboard_model.g.dart';

@JsonSerializable()
class DashboardModel {
  final String? url;
  final String? title;
  final String? body;
  final String? price;

  DashboardModel({this.title, this.body, this.price, this.url});

  @override
  DashboardModel fromJson(Map<String, Object?> json) {
    return _$DashboardModelFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$DashboardModelToJson(this);
  }
}
