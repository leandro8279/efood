// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigApiModel _$ConfigApiModelFromJson(Map<String, dynamic> json) =>
    ConfigApiModel(
      restaurantName: json['restaurant_name'] as String,
      restaurantLogo: json['restaurant_logo'] as String,
      currencySymbol: json['currency_symbol'] as String,
      maintenanceMode: json['maintenance_mode'] as bool,
      emailVerification: json['email_verification'] as bool,
      phoneVerification: json['phone_verification'] as bool,
      baseUrls: BaseUrlApiModel.fromJson(
        json['base_urls'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ConfigApiModelToJson(ConfigApiModel instance) =>
    <String, dynamic>{
      'restaurant_name': instance.restaurantName,
      'restaurant_logo': instance.restaurantLogo,
      'currency_symbol': instance.currencySymbol,
      'maintenance_mode': instance.maintenanceMode,
      'email_verification': instance.emailVerification,
      'phone_verification': instance.phoneVerification,
      'base_urls': instance.baseUrls.toJson(),
    };
