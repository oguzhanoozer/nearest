// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) =>
    DashboardModel(
      title: json['title'] as String?,
      body: json['body'] as String?,
      price: json['price'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'body': instance.body,
      'price': instance.price,
    };
