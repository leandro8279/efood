// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_branch_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantBranchApiModel _$RestaurantBranchApiModelFromJson(Map<String, dynamic> json) => RestaurantBranchApiModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  longitude: json['longitude'] as String,
  latitude: json['latitude'] as String,
  address: json['address'] as String,
  coverage: (json['coverage'] as num).toInt(),
);

Map<String, dynamic> _$RestaurantBranchApiModelToJson(RestaurantBranchApiModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'longitude': instance.longitude,
  'latitude': instance.latitude,
  'address': instance.address,
  'coverage': instance.coverage,
};
