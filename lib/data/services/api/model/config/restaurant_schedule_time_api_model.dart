import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_schedule_time_api_model.g.dart';

@JsonSerializable()
class const RestaurantScheduleTimeApiModel({
  required final int day,
  required final String openingTime,
  required final String closingTime,
}) extends Equatable {
  factory RestaurantScheduleTimeApiModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantScheduleTimeApiModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RestaurantScheduleTimeApiModelToJson(this);

  @override
  List<Object?> get props => [day, openingTime, closingTime];
}
