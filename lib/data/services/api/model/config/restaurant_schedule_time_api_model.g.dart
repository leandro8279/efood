// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_schedule_time_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantScheduleTimeApiModel _$RestaurantScheduleTimeApiModelFromJson(
  Map<String, dynamic> json,
) => RestaurantScheduleTimeApiModel(
  day: (json['day'] as num).toInt(),
  openingTime: json['opening_time'] as String,
  closingTime: json['closing_time'] as String,
);

Map<String, dynamic> _$RestaurantScheduleTimeApiModelToJson(
  RestaurantScheduleTimeApiModel instance,
) => <String, dynamic>{
  'day': instance.day,
  'opening_time': instance.openingTime,
  'closing_time': instance.closingTime,
};
