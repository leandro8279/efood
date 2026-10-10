// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(
  Map<String, dynamic> json,
) => ProductApiModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  image: json['image'] as String,
  price: (json['price'] as num).toDouble(),
  variations: (json['variations'] as List<dynamic>)
      .map((e) => ProductVariationApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  addOns: (json['add_ons'] as List<dynamic>)
      .map((e) => ProductAddOnApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  tax: (json['tax'] as num).toDouble(),
  availableTimeStarts: json['available_time_starts'] as String,
  availableTimeEnds: json['available_time_ends'] as String,
  status: (json['status'] as num).toInt(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  attributes: json['attributes'] as List<dynamic>,
  categoryIds: (json['category_ids'] as List<dynamic>)
      .map((e) => ProductCategoryIdApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  choiceOptions: json['choice_options'] as List<dynamic>,
  discount: (json['discount'] as num).toDouble(),
  discountType: json['discount_type'] as String,
  taxType: json['tax_type'] as String,
  setMenu: (json['set_menu'] as num).toInt(),
  branchId: json['branch_id'] as String,
  colors: (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
  popularityCount: (json['popularity_count'] as num).toInt(),
  productType: json['product_type'] as String,
  rating: json['rating'] as List<dynamic>,
);

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'variations': instance.variations.map((e) => e.toJson()).toList(),
      'add_ons': instance.addOns.map((e) => e.toJson()).toList(),
      'tax': instance.tax,
      'available_time_starts': instance.availableTimeStarts,
      'available_time_ends': instance.availableTimeEnds,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'attributes': instance.attributes,
      'category_ids': instance.categoryIds.map((e) => e.toJson()).toList(),
      'choice_options': instance.choiceOptions,
      'discount': instance.discount,
      'discount_type': instance.discountType,
      'tax_type': instance.taxType,
      'set_menu': instance.setMenu,
      'branch_id': instance.branchId,
      'colors': instance.colors,
      'popularity_count': instance.popularityCount,
      'product_type': instance.productType,
      'rating': instance.rating,
    };

ProductVariationApiModel _$ProductVariationApiModelFromJson(Map<String, dynamic> json) =>
    ProductVariationApiModel(type: json['type'] as String, price: (json['price'] as num).toDouble());

Map<String, dynamic> _$ProductVariationApiModelToJson(ProductVariationApiModel instance) => <String, dynamic>{
  'type': instance.type,
  'price': instance.price,
};

ProductAddOnApiModel _$ProductAddOnApiModelFromJson(
  Map<String, dynamic> json,
) => ProductAddOnApiModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  translations: json['translations'] as List<dynamic>,
);

Map<String, dynamic> _$ProductAddOnApiModelToJson(
  ProductAddOnApiModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'translations': instance.translations,
};

ProductCategoryIdApiModel _$ProductCategoryIdApiModelFromJson(
  Map<String, dynamic> json,
) => ProductCategoryIdApiModel(
  id: json['id'] as String,
  position: (json['position'] as num).toInt(),
);

Map<String, dynamic> _$ProductCategoryIdApiModelToJson(
  ProductCategoryIdApiModel instance,
) => <String, dynamic>{'id': instance.id, 'position': instance.position};
