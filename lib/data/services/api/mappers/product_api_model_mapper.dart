import 'package:efood/data/services/api/model/product/product_api_model.dart';
import 'package:efood/domain/models/product/product.dart';

extension ProductApiModelMapper on ProductApiModel {
  Product toDomain() => Product(
    id: id,
    name: name,
    description: description,
    image: image,
    price: price,
    variations: variations.isNotEmpty ? variations.map((s) => s!.toDomain()).toList() : [],
    addOns: addOns.isNotEmpty ? addOns.map((addOn) => addOn.toDomain()).toList() : [],
    tax: tax,
    availableTimeStarts: availableTimeStarts,
    availableTimeEnds: availableTimeEnds,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
    attributes: attributes,
    categoryIds: categoryIds.isNotEmpty ? categoryIds.map((categoryId) => categoryId!.toDomain()).toList() : [],
    choiceOptions: choiceOptions.isNotEmpty ? choiceOptions.map((e) => e!.toDomain()).toList() : [],
    discount: discount,
    discountType: discountType,
    taxType: taxType,
    setMenu: setMenu,
    branchId: branchId,
    colors: colors,
    popularityCount: popularityCount,
    productType: productType,
    rating: rating.isNotEmpty ? rating.map((s) => s!.toDomain()).toList() : [],
  );
}

extension ProductAddOnApiModelMapper on ProductAddOnApiModel {
  ProductAddOn toDomain() => ProductAddOn(
    id: id,
    name: name,
    price: price,
    createdAt: createdAt,
    updatedAt: updatedAt,
    translations: translations,
  );
}

extension ProductCategoryIdApiModelMapper on ProductCategoryIdApiModel {
  ProductCategoryId toDomain() => ProductCategoryId(id: id, position: position);
}

extension ProductRatingModelMapper on ProductRatingApiModel {
  ProductRating toDomain() => ProductRating(average: average);
}

extension ProductChoiceOptionModelMapper on ProductChoiceOptionApiModel {
  ProductChoiceOption toDomain() {
    return ProductChoiceOption(
      name: name,
      title: title,
      options: options.isNotEmpty ? options.map((s) => s!).toList() : [],
    );
  }
}

extension ProductVariationModelMapper on ProductVariationApiModel {
  ProductVariation toDomain() => ProductVariation(price: price, type: type);
}
