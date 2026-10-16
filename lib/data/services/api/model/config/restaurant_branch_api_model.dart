import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_branch_api_model.g.dart';

@JsonSerializable()
class const RestaurantBranchApiModel({
  required final int id,
  required final String name,
  required final String email,
  required final String longitude,
  required final String latitude,
  required final String address,
  required final int coverage,
}) extends Equatable {
  factory RestaurantBranchApiModel.fromJson(Map<String, dynamic> json) => _$RestaurantBranchApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantBranchApiModelToJson(this);

  @override
  List<Object?> get props => [id, name, email, longitude, latitude, address, coverage];
}
