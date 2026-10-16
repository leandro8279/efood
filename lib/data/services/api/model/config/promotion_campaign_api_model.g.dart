// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_campaign_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionCampaignApiModel _$PromotionCampaignApiModelFromJson(Map<String, dynamic> json) =>
    PromotionCampaignApiModel(
      id: (json['id'] as num).toInt(),
      restaurantId: (json['restaurant_id'] as num?)?.toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      address: json['address'] as String,
      status: (json['status'] as num).toInt(),
      branchPromotionStatus: (json['branch_promotion_status'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      coverage: (json['coverage'] as num).toInt(),
      image: json['image'] as String,
      branchPromotion: List<Object?>.from(json['branch_promotion'] as List<dynamic>),
    );

Map<String, dynamic> _$PromotionCampaignApiModelToJson(PromotionCampaignApiModel instance) => <String, dynamic>{
  'id': instance.id,
  'restaurant_id': instance.restaurantId,
  'name': instance.name,
  'email': instance.email,
  'longitude': instance.longitude,
  'latitude': instance.latitude,
  'address': instance.address,
  'status': instance.status,
  'branch_promotion_status': instance.branchPromotionStatus,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'coverage': instance.coverage,
  'image': instance.image,
  'branch_promotion': instance.branchPromotion,
};
