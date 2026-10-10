// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerApiModel _$BannerApiModelFromJson(Map<String, dynamic> json) =>
    BannerApiModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      image: json['image'] as String,
      productId: (json['product_id'] as num?)?.toInt(),
      status: (json['status'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      categoryId: (json['category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BannerApiModelToJson(BannerApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'product_id': instance.productId,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'category_id': instance.categoryId,
    };
