import 'package:efood/data/services/api/model/config/base_url_api_model.dart';
import 'package:efood/data/services/api/model/config/delivery_management_api_model.dart';
import 'package:efood/data/services/api/model/config/promotion_campaign_api_model.dart';
import 'package:efood/data/services/api/model/config/restaurant_branch_api_model.dart';
import 'package:efood/data/services/api/model/config/restaurant_location_coverage_api_model.dart';
import 'package:efood/data/services/api/model/config/restaurant_schedule_time_api_model.dart';
import 'package:efood/data/services/api/model/config/store_config_api_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'config_api_model.g.dart';

@JsonSerializable()
class const ConfigApiModel({
  required final String restaurantName,
  required final String restaurantLogo,
  required final String? restaurantOpenTime,
  required final String? restaurantCloseTime,
  required final String restaurantAddress,
  required final String restaurantPhone,
  required final String restaurantEmail,
  required final String currencySymbol,
  required final RestaurantLocationCoverageApiModel restaurantLocationCoverage,
  required final double minimumOrderValue,
  required final bool maintenanceMode,
  required final bool emailVerification,
  required final bool phoneVerification,
  required final BaseUrlApiModel baseUrls,
  required final int decimalPointSettings,
  required final String currencySymbolPosition,
  required final String softwareVersion,
  required final double deliveryCharge,
  @JsonKey(name: 'delivery')
  required final bool homeDelivery,
  required final bool selfPickup,
  required final DeliveryManagementApiModel deliveryManagement,
  required final String cashOnDelivery,
  required final String digitalPayment,
  required final List<RestaurantBranchApiModel> branches,
  required final String termsAndConditions,
  required final String privacyPolicy,
  required final String aboutUs,
  required final String? timeFormat,
  required final List<RestaurantScheduleTimeApiModel> restaurantScheduleTime,
  required final String country,
  required final StoreConfigApiModel playStoreConfig,
  required final StoreConfigApiModel appStoreConfig,
  required final List<Object?> socialMediaLink,
  required final String footerText,
  required final int scheduleOrderSlotDuration,
  required final List<PromotionCampaignApiModel> promotionCampaign,
}) extends Equatable {
  factory ConfigApiModel.fromJson(Map<String, dynamic> json) {
    return _$ConfigApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConfigApiModelToJson(this);

  @override
  List<Object?> get props => [
    restaurantName,
    restaurantLogo,
    restaurantOpenTime,
    restaurantCloseTime,
    restaurantAddress,
    restaurantPhone,
    restaurantEmail,
    currencySymbol,
    restaurantLocationCoverage,
    minimumOrderValue,
    maintenanceMode,
    emailVerification,
    phoneVerification,
    baseUrls,
    decimalPointSettings,
    currencySymbolPosition,
    softwareVersion,
    deliveryCharge,
    homeDelivery,
    selfPickup,
    deliveryManagement,
    cashOnDelivery,
    digitalPayment,
    branches,
    termsAndConditions,
    privacyPolicy,
    aboutUs,
    timeFormat,
    restaurantScheduleTime,
    country,
    playStoreConfig,
    appStoreConfig,
    socialMediaLink,
    footerText,
    scheduleOrderSlotDuration,
    promotionCampaign,
  ];
}
