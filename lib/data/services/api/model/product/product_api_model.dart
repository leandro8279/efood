import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_api_model.g.dart';

@JsonSerializable()
class const ProductApiModel({
  required final int id,
  required final String name,
  required final String description,
  required final String image,
  required final double price,
  required final List<ProductVariationApiModel?> variations,
  required final List<ProductAddOnApiModel> addOns,
  required final double tax,
  required final String availableTimeStarts,
  required final String availableTimeEnds,
  required final int status,
  required final String createdAt,
  required final String updatedAt,
  required final List<Object?> attributes,
  required final List<ProductCategoryIdApiModel?> categoryIds,
  required final List<ProductChoiceOptionApiModel?> choiceOptions,
  required final double discount,
  required final String discountType,
  required final String taxType,
  required final int setMenu,
  required final int branchId,
  required final List<String> colors,
  required final int popularityCount,
  required final String productType,
  required final List<ProductRatingApiModel?> rating,
}) extends Equatable {
  factory ProductApiModel.fromJson(Map<String, dynamic> json) => _$ProductApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    image,
    price,
    variations,
    addOns,
    tax,
    availableTimeStarts,
    availableTimeEnds,
    status,
    createdAt,
    updatedAt,
    attributes,
    categoryIds,
    choiceOptions,
    discount,
    discountType,
    taxType,
    setMenu,
    branchId,
    colors,
    popularityCount,
    productType,
    rating,
  ];
}

@JsonSerializable()
class const ProductVariationApiModel({required final String type, required final double price}) extends Equatable {
  factory ProductVariationApiModel.fromJson(Map<String, dynamic> json) => _$ProductVariationApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariationApiModelToJson(this);

  @override
  List<Object?> get props => [type, price];
}

@JsonSerializable()
class const ProductAddOnApiModel({
  required final int id,
  required final String name,
  required final double price,
  required final String createdAt,
  required final String updatedAt,
  required final List<Object?> translations,
}) extends Equatable {
  factory ProductAddOnApiModel.fromJson(Map<String, dynamic> json) => _$ProductAddOnApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAddOnApiModelToJson(this);

  @override
  List<Object?> get props => [id, name, price, createdAt, updatedAt, translations];
}

@JsonSerializable()
class const ProductCategoryIdApiModel({required final String id, required final int position}) extends Equatable {
  factory ProductCategoryIdApiModel.fromJson(Map<String, dynamic> json) => _$ProductCategoryIdApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryIdApiModelToJson(this);

  @override
  List<Object?> get props => [id, position];
}

@JsonSerializable()
class const ProductRatingApiModel({required final String average}) extends Equatable {
  factory ProductRatingApiModel.fromJson(Map<String, dynamic> json) => _$ProductRatingApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRatingApiModelToJson(this);

  @override
  List<Object?> get props => [average];
}

@JsonSerializable()
class const ProductChoiceOptionApiModel({
  required final String name,
  required final String title,
  required final List<String?> options,
}) extends Equatable {
  factory ProductChoiceOptionApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductChoiceOptionApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductChoiceOptionApiModelToJson(this);

  @override
  List<Object?> get props => [name, title, options];
}
