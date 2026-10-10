import 'package:efood/data/services/api/model/product/product_api_model.dart';
import 'package:efood/domain/models/product/product.dart';

extension ProductApiModelMapper on ProductApiModel {
  Product toDomain() => Product(
    id: id,
    name: name,
    description: description,
    image: image,
    price: price,
    variations: variations,
    addOns: addOns.map((addOn) => addOn.toDomain()).toList(),
    tax: tax,
    availableTimeStarts: availableTimeStarts,
    availableTimeEnds: availableTimeEnds,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
    attributes: attributes,
    categoryIds: categoryIds.map((categoryId) => categoryId.toDomain()).toList(),
    choiceOptions: choiceOptions,
    discount: discount,
    discountType: discountType,
    taxType: taxType,
    setMenu: setMenu,
    branchId: branchId,
    colors: colors,
    popularityCount: popularityCount,
    productType: productType,
    rating: rating,
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
