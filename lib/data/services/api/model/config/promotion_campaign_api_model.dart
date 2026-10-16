import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'promotion_campaign_api_model.g.dart';

@JsonSerializable()
class const PromotionCampaignApiModel({
  required final int id,
  required final int? restaurantId,
  required final String name,
  required final String email,
  required final String longitude,
  required final String latitude,
  required final String address,
  required final int status,
  required final int branchPromotionStatus,
  required final String createdAt,
  required final String updatedAt,
  required final int coverage,
  required final String image,
  required final List<Object?> branchPromotion,
}) extends Equatable {
  factory PromotionCampaignApiModel.fromJson(Map<String, dynamic> json) => _$PromotionCampaignApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionCampaignApiModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    restaurantId,
    name,
    email,
    longitude,
    latitude,
    address,
    status,
    branchPromotionStatus,
    createdAt,
    updatedAt,
    coverage,
    image,
    branchPromotion,
  ];
}
