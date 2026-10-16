// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_config_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreConfigApiModel _$StoreConfigApiModelFromJson(Map<String, dynamic> json) => StoreConfigApiModel(
  status: json['status'] as bool,
  link: json['link'] as String,
  minVersion: json['min_version'] as String,
);

Map<String, dynamic> _$StoreConfigApiModelToJson(StoreConfigApiModel instance) => <String, dynamic>{
  'status': instance.status,
  'link': instance.link,
  'min_version': instance.minVersion,
};
