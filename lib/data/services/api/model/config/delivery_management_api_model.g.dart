// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_management_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryManagementApiModel _$DeliveryManagementApiModelFromJson(Map<String, dynamic> json) =>
    DeliveryManagementApiModel(
      status: (json['status'] as num).toInt(),
      minShippingCharge: (json['min_shipping_charge'] as num).toDouble(),
      shippingPerKm: (json['shipping_per_km'] as num).toDouble(),
    );

Map<String, dynamic> _$DeliveryManagementApiModelToJson(DeliveryManagementApiModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'min_shipping_charge': instance.minShippingCharge,
      'shipping_per_km': instance.shippingPerKm,
    };
