import 'package:efood/data/services/api/model/config/base_url_api_model.dart';
import 'package:efood/data/services/api/model/config/config_api_model.dart';
import 'package:efood/data/services/api/model/config/restaurant_schedule_time_api_model.dart';
import 'package:efood/domain/models/config/base_url.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/config/restaurant_schedule_time.dart';

extension ConfigApiModelMapper on ConfigApiModel {
  Config toDomain() => Config(
    restaurantName: restaurantName,
    restaurantLogo: restaurantLogo,
    currencySymbol: currencySymbol,
    maintenanceMode: maintenanceMode,
    emailVerification: true,
    phoneVerification: false,
    baseUrls: baseUrls.toDomain(),
    currencySymbolPosition: currencySymbolPosition,
    decimalPointSettings: decimalPointSettings,
    restaurantScheduleTime: restaurantScheduleTime
        .map((schedule) => schedule.toDomain())
        .toList(),
  );
}

extension RestaurantScheduleTimeApiModelMapper
    on RestaurantScheduleTimeApiModel {
  RestaurantScheduleTime toDomain() => RestaurantScheduleTime(
    day: day,
    openingTime: openingTime,
    closingTime: closingTime,
  );
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
