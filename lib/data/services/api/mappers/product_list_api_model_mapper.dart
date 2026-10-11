import 'package:efood/data/services/api/model/product/product_list_api_model.dart';
import 'package:efood/data/services/api/mappers/product_api_model_mapper.dart';
import 'package:efood/domain/models/product/product_list.dart';

extension ProductListApiModelMapper on ProductListApiModel {
  ProductList toDomain() => ProductList(
    totalSize: totalSize,
    limit: limit,
    offset: offset,
    products: products.map((product) => product.toDomain()).toList(),
  );
}
