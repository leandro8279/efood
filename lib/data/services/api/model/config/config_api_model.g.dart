// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigApiModel _$ConfigApiModelFromJson(Map<String, dynamic> json) => ConfigApiModel(
  restaurantName: json['restaurant_name'] as String,
  restaurantLogo: json['restaurant_logo'] as String,
  restaurantOpenTime: json['restaurant_open_time'] as String?,
  restaurantCloseTime: json['restaurant_close_time'] as String?,
  restaurantAddress: json['restaurant_address'] as String,
  restaurantPhone: json['restaurant_phone'] as String,
  restaurantEmail: json['restaurant_email'] as String,
  currencySymbol: json['currency_symbol'] as String,
  restaurantLocationCoverage: RestaurantLocationCoverageApiModel.fromJson(
    json['restaurant_location_coverage'] as Map<String, dynamic>,
  ),
  minimumOrderValue: (json['minimum_order_value'] as num).toDouble(),
  maintenanceMode: json['maintenance_mode'] as bool,
  emailVerification: json['email_verification'] as bool,
  phoneVerification: json['phone_verification'] as bool,
  baseUrls: BaseUrlApiModel.fromJson(json['base_urls'] as Map<String, dynamic>),
  decimalPointSettings: (json['decimal_point_settings'] as num).toInt(),
  currencySymbolPosition: json['currency_symbol_position'] as String,
  softwareVersion: json['software_version'] as String,
  deliveryCharge: (json['delivery_charge'] as num).toDouble(),
  homeDelivery: json['delivery'] as bool,
  selfPickup: json['self_pickup'] as bool,
  deliveryManagement: DeliveryManagementApiModel.fromJson(
    json['delivery_management'] as Map<String, dynamic>,
  ),
  cashOnDelivery: json['cash_on_delivery'] as String,
  digitalPayment: json['digital_payment'] as String,
  branches: (json['branches'] as List<dynamic>)
      .map((e) => RestaurantBranchApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  termsAndConditions: json['terms_and_conditions'] as String,
  privacyPolicy: json['privacy_policy'] as String,
  aboutUs: json['about_us'] as String,
  timeFormat: json['time_format'] as String?,
  restaurantScheduleTime: (json['restaurant_schedule_time'] as List<dynamic>)
      .map((e) => RestaurantScheduleTimeApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  country: json['country'] as String,
  playStoreConfig: StoreConfigApiModel.fromJson(json['play_store_config'] as Map<String, dynamic>),
  appStoreConfig: StoreConfigApiModel.fromJson(json['app_store_config'] as Map<String, dynamic>),
  socialMediaLink: List<Object?>.from(json['social_media_link'] as List<dynamic>),
  footerText: json['footer_text'] as String,
  scheduleOrderSlotDuration: (json['schedule_order_slot_duration'] as num).toInt(),
  promotionCampaign: (json['promotion_campaign'] as List<dynamic>)
      .map((e) => PromotionCampaignApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ConfigApiModelToJson(ConfigApiModel instance) => <String, dynamic>{
  'restaurant_name': instance.restaurantName,
  'restaurant_logo': instance.restaurantLogo,
  'restaurant_open_time': instance.restaurantOpenTime,
  'restaurant_close_time': instance.restaurantCloseTime,
  'restaurant_address': instance.restaurantAddress,
  'restaurant_phone': instance.restaurantPhone,
  'restaurant_email': instance.restaurantEmail,
  'currency_symbol': instance.currencySymbol,
  'restaurant_location_coverage': instance.restaurantLocationCoverage.toJson(),
  'minimum_order_value': instance.minimumOrderValue,
  'maintenance_mode': instance.maintenanceMode,
  'email_verification': instance.emailVerification,
  'phone_verification': instance.phoneVerification,
  'base_urls': instance.baseUrls.toJson(),
  'decimal_point_settings': instance.decimalPointSettings,
  'currency_symbol_position': instance.currencySymbolPosition,
  'software_version': instance.softwareVersion,
  'delivery_charge': instance.deliveryCharge,
  'delivery': instance.homeDelivery,
  'self_pickup': instance.selfPickup,
  'delivery_management': instance.deliveryManagement.toJson(),
  'cash_on_delivery': instance.cashOnDelivery,
  'digital_payment': instance.digitalPayment,
  'branches': instance.branches.map((e) => e.toJson()).toList(),
  'terms_and_conditions': instance.termsAndConditions,
  'privacy_policy': instance.privacyPolicy,
  'about_us': instance.aboutUs,
  'time_format': instance.timeFormat,
  'restaurant_schedule_time': instance.restaurantScheduleTime.map((e) => e.toJson()).toList(),
  'country': instance.country,
  'play_store_config': instance.playStoreConfig.toJson(),
  'app_store_config': instance.appStoreConfig.toJson(),
  'social_media_link': instance.socialMediaLink,
  'footer_text': instance.footerText,
  'schedule_order_slot_duration': instance.scheduleOrderSlotDuration,
  'promotion_campaign': instance.promotionCampaign.map((e) => e.toJson()).toList(),
};
