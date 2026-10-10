import 'package:efood/data/services/api/model/config/base_url_api_model.dart';
import 'package:efood/data/services/api/model/config/config_api_model.dart';
import 'package:efood/domain/models/config/base_url.dart';
import 'package:efood/domain/models/config/config.dart';

extension ConfigApiModelMapper on ConfigApiModel {
  Config toDomain() => Config(
    restaurantName: restaurantName,
    restaurantLogo: restaurantLogo,
    currencySymbol: currencySymbol,
    maintenanceMode: maintenanceMode,
    emailVerification: true,
    phoneVerification: false,
    baseUrls: baseUrls.toDomain(),
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
