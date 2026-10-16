// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_location_coverage_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantLocationCoverageApiModel _$RestaurantLocationCoverageApiModelFromJson(Map<String, dynamic> json) =>
    RestaurantLocationCoverageApiModel(
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      coverage: (json['coverage'] as num).toInt(),
    );

Map<String, dynamic> _$RestaurantLocationCoverageApiModelToJson(RestaurantLocationCoverageApiModel instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'coverage': instance.coverage,
    };
