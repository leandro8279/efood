import 'package:equatable/equatable.dart';

class const Product({
  required final int id,
  required final String name,
  required final String description,
  required final String image,
  required final double price,
  required final List<ProductVariation> variations,
  required final List<ProductAddOn> addOns,
  required final double tax,
  required final String availableTimeStarts,
  required final String availableTimeEnds,
  required final int status,
  required final String createdAt,
  required final String updatedAt,
  required final List<Object?> attributes,
  required final List<ProductCategoryId> categoryIds,
  required final List<Object?> choiceOptions,
  required final double discount,
  required final String discountType,
  required final String taxType,
  required final int setMenu,
  required final String branchId,
  required final List<String>? colors,
  required final String popularityCount,
  required final String productType,
  required final List<ProductRating?> rating,
}) extends Equatable {
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

class const ProductVariation({required final String type, required final double price}) extends Equatable {
  @override
  List<Object?> get props => [type, price];
}

class const ProductRating({required final String average}) extends Equatable {
  @override
  List<Object?> get props => [average];
}

class const ProductAddOn({
  required final int id,
  required final String name,
  required final double price,
  required final String createdAt,
  required final String updatedAt,
  required final List<Object?> translations,
}) extends Equatable {
  @override
  List<Object?> get props => [id, name, price, createdAt, updatedAt, translations];
}

class const ProductCategoryId({required final String id, required final int position}) extends Equatable {
  @override
  List<Object?> get props => [id, position];
}
