import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_location_coverage_api_model.g.dart';

@JsonSerializable()
class const RestaurantLocationCoverageApiModel({
  required final String longitude,
  required final String latitude,
  required final int coverage,
}) extends Equatable {
  factory RestaurantLocationCoverageApiModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantLocationCoverageApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantLocationCoverageApiModelToJson(this);

  @override
  List<Object?> get props => [longitude, latitude, coverage];
}
