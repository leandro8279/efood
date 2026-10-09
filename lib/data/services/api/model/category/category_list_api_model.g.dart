// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryListApiModel _$CategoryListApiModelFromJson(
  Map<String, dynamic> json,
) => CategoryListApiModel(
  totalSize: (json['total_size'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  offset: (json['offset'] as num).toInt(),
  categories: (json['categories'] as List<dynamic>)
      .map((e) => CategoryApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CategoryListApiModelToJson(
  CategoryListApiModel instance,
) => <String, dynamic>{
  'total_size': instance.totalSize,
  'limit': instance.limit,
  'offset': instance.offset,
  'categories': instance.categories,
};
