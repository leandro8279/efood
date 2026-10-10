import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'base_url_api_model.g.dart';

@JsonSerializable()
class const BaseUrlApiModel({
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
  factory BaseUrlApiModel.fromJson(Map<String, dynamic> json) {
    return _$BaseUrlApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BaseUrlApiModelToJson(this);

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
