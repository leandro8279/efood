import 'package:efood/data/services/local/model/cart/cart_add_on_local_model.dart';
import 'package:efood/data/services/local/model/cart/cart_local_model.dart';
import 'package:efood/data/services/local/model/cart/product_local_model.dart';
import 'package:efood/data/services/local/model/cart/product_variation_local_model.dart';
import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/domain/models/product/product.dart';

extension CartLocalModelMapper on CartLocalModel {
  Cart toDomain() => Cart(
    price: price,
    quantity: quantity,
    taxAmount: taxAmount,
    product: product.toDomain(),
    discountAmount: discountAmount,
    discountedPrice: discountAmount,
    addOnIds: addOnIds.isNotEmpty ? addOnIds.map((s) => s.toDomain()).toList() : [],
    variation: variation.isNotEmpty ? variation.map((s) => s!.toDomain()).toList() : [],
  );
}

extension CartAddOnModelMapper on CartAddOnLocalModel {
  CartAddOn toDomain() => CartAddOn(id: id, quantity: quantity);
}

extension ProductVariationLocalModelMapper on ProductVariationLocalModel {
  ProductVariation toDomain() => ProductVariation(price: price, type: type);
}

extension ProductLocalModelMapper on ProductLocalModel {
  Product toDomain() => Product(
    id: 1,
    name: '',
    description: '',
    image: '',
    price: 1,
    variations: [],
    addOns: [],
    tax: 1,
    availableTimeStarts: '',
    availableTimeEnds: '',
    status: 1,
    createdAt: '',
    updatedAt: '',
    attributes: [],
    categoryIds: [],
    choiceOptions: [],
    discount: 1,
    discountType: '',
    taxType: '',
    setMenu: 1,
    branchId: 1,
    colors: [],
    popularityCount: 1,
    productType: '',
    rating: [],
  );
}
