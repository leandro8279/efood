// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListApiModel _$ProductListApiModelFromJson(Map<String, dynamic> json) =>
    ProductListApiModel(
      totalSize: (json['total_size'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductListApiModelToJson(
  ProductListApiModel instance,
) => <String, dynamic>{
  'total_size': instance.totalSize,
  'limit': instance.limit,
  'offset': instance.offset,
  'products': instance.products.map((e) => e.toJson()).toList(),
};
