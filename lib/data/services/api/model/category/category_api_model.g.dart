// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryApiModel _$CategoryApiModelFromJson(Map<String, dynamic> json) =>
    CategoryApiModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      parentId: (json['parent_id'] as num).toInt(),
      position: (json['position'] as num).toInt(),
      status: (json['status'] as num).toInt(),
      priority: (json['priority'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      image: json['image'] as String,
      bannerImage: json['banner_image'] as String?,
      children:
          (json['childes'] as List<dynamic>?)
              ?.map(
                (e) => CategoryApiModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <CategoryApiModel>[],
    );

Map<String, dynamic> _$CategoryApiModelToJson(CategoryApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parent_id': instance.parentId,
      'position': instance.position,
      'status': instance.status,
      'priority': instance.priority,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'image': instance.image,
      'banner_image': instance.bannerImage,
      'childes': instance.children,
    };
