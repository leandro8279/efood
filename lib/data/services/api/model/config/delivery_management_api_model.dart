import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'delivery_management_api_model.g.dart';

@JsonSerializable()
class const DeliveryManagementApiModel({
  required final int status,
  required final double minShippingCharge,
  required final double shippingPerKm,
}) extends Equatable {
  factory DeliveryManagementApiModel.fromJson(Map<String, dynamic> json) {
    return _$DeliveryManagementApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeliveryManagementApiModelToJson(this);

  @override
  List<Object?> get props => [status, minShippingCharge, shippingPerKm];
}
