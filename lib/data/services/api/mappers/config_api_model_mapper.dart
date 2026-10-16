import 'package:efood/data/services/api/model/config/base_url_api_model.dart';
import 'package:efood/data/services/api/model/config/config_api_model.dart';
import 'package:efood/data/services/api/model/config/delivery_management_api_model.dart';
import 'package:efood/data/services/api/model/config/promotion_campaign_api_model.dart';
import 'package:efood/data/services/api/model/config/restaurant_branch_api_model.dart';
import 'package:efood/data/services/api/model/config/restaurant_location_coverage_api_model.dart';
import 'package:efood/data/services/api/model/config/restaurant_schedule_time_api_model.dart';
import 'package:efood/data/services/api/model/config/store_config_api_model.dart';
import 'package:efood/domain/models/config/base_url.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/config/delivery_management.dart';
import 'package:efood/domain/models/config/promotion_campaign.dart';
import 'package:efood/domain/models/config/restaurant_branch.dart';
import 'package:efood/domain/models/config/restaurant_location_coverage.dart';
import 'package:efood/domain/models/config/restaurant_schedule_time.dart';
import 'package:efood/domain/models/config/store_config.dart';

extension ConfigApiModelMapper on ConfigApiModel {
  Config toDomain() => Config(
    restaurantName: restaurantName,
    restaurantLogo: restaurantLogo,
    restaurantOpenTime: restaurantOpenTime,
    restaurantCloseTime: restaurantCloseTime,
    restaurantAddress: restaurantAddress,
    restaurantPhone: restaurantPhone,
    restaurantEmail: restaurantEmail,
    currencySymbol: currencySymbol,
    restaurantLocationCoverage: restaurantLocationCoverage.toDomain(),
    minimumOrderValue: minimumOrderValue,
    maintenanceMode: maintenanceMode,
    emailVerification: emailVerification,
    phoneVerification: phoneVerification,
    baseUrls: baseUrls.toDomain(),
    softwareVersion: softwareVersion,
    timeFormat: timeFormat,
    currencySymbolPosition: currencySymbolPosition,
    decimalPointSettings: decimalPointSettings,
    deliveryCharge: deliveryCharge,
    homeDelivery: homeDelivery,
    selfPickup: selfPickup,
    deliveryManagement: deliveryManagement.toDomain(),
    cashOnDelivery: cashOnDelivery,
    digitalPayment: digitalPayment,
    branches: branches.map((branch) => branch.toDomain()).toList(),
    termsAndConditions: termsAndConditions,
    privacyPolicy: privacyPolicy,
    aboutUs: aboutUs,
    country: country,
    playStoreConfig: playStoreConfig.toDomain(),
    appStoreConfig: appStoreConfig.toDomain(),
    socialMediaLink: List<Object?>.of(socialMediaLink),
    footerText: footerText,
    scheduleOrderSlotDuration: scheduleOrderSlotDuration,
    promotionCampaign: promotionCampaign.map((campaign) => campaign.toDomain()).toList(),
    restaurantScheduleTime: restaurantScheduleTime.map((schedule) => schedule.toDomain()).toList(),
  );
}

extension DeliveryManagementApiModelMapper on DeliveryManagementApiModel {
  DeliveryManagement toDomain() =>
      DeliveryManagement(status: status, minShippingCharge: minShippingCharge, shippingPerKm: shippingPerKm);
}

extension RestaurantLocationCoverageApiModelMapper on RestaurantLocationCoverageApiModel {
  RestaurantLocationCoverage toDomain() =>
      RestaurantLocationCoverage(longitude: longitude, latitude: latitude, coverage: coverage);
}

extension StoreConfigApiModelMapper on StoreConfigApiModel {
  StoreConfig toDomain() => StoreConfig(status: status, link: link, minVersion: minVersion);
}

extension RestaurantBranchApiModelMapper on RestaurantBranchApiModel {
  RestaurantBranch toDomain() =>
      RestaurantBranch(id: id, name: name, email: email, longitude: longitude, latitude: latitude, address: address, coverage: coverage);
}

extension PromotionCampaignApiModelMapper on PromotionCampaignApiModel {
  PromotionCampaign toDomain() => PromotionCampaign(
    id: id,
    restaurantId: restaurantId,
    name: name,
    email: email,
    longitude: longitude,
    latitude: latitude,
    address: address,
    status: status,
    branchPromotionStatus: branchPromotionStatus,
    createdAt: createdAt,
    updatedAt: updatedAt,
    coverage: coverage,
    image: image,
    branchPromotion: List<Object?>.of(branchPromotion),
  );
}

extension RestaurantScheduleTimeApiModelMapper on RestaurantScheduleTimeApiModel {
  RestaurantScheduleTime toDomain() =>
      RestaurantScheduleTime(day: day, openingTime: openingTime, closingTime: closingTime);
}

extension BaseUrlApiModelMapper on BaseUrlApiModel {
  BaseUrl toDomain() => BaseUrl(
    bannerImageUrl: bannerImageUrl,
    categoryBannerImageUrl: categoryBannerImageUrl,
    categoryImageUrl: categoryImageUrl,
    chatImageUrl: chatImageUrl,
    customerImageUrl: customerImageUrl,
    deliveryManImageUrl: deliveryManImageUrl,
    kitchenImageUrl: kitchenImageUrl,
    notificationImageUrl: notificationImageUrl,
    productImageUrl: productImageUrl,
    promotionalUrl: promotionalUrl,
    restaurantImageUrl: restaurantImageUrl,
    reviewImageUrl: reviewImageUrl,
  );
}
