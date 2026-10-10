import 'package:equatable/equatable.dart';

class const BaseUrl({
  required final String productImageUrl,
  required final String customerImageUrl,
  required final String bannerImageUrl,
  required final String categoryImageUrl,
  required final String categoryBannerImageUrl,
  required final String reviewImageUrl,
  required final String notificationImageUrl,
  required final String restaurantImageUrl,
  required final String deliveryManImageUrl,
  required final String chatImageUrl,
  required final String promotionalUrl,
  required final String kitchenImageUrl,
}) extends Equatable {
  @override
  List<Object?> get props => [
    productImageUrl,
    customerImageUrl,
    bannerImageUrl,
    categoryImageUrl,
    categoryBannerImageUrl,
    reviewImageUrl,
    notificationImageUrl,
    restaurantImageUrl,
    deliveryManImageUrl,
    chatImageUrl,
    promotionalUrl,
    kitchenImageUrl,
  ];
}
