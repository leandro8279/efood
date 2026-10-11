import 'package:efood/domain/models/product/product.dart';
import 'package:efood/domain/models/product/product_list.dart';
import 'package:efood/utils/result.dart';

abstract interface class ProductRepository {
  Future<Result<ProductList>> getLatestProductList({required int offset});

  Future<Result<ProductList>> getPopularProductList({
    required int offset,
    required String productType,
  });

  Future<Result<Product>> getProductById({required int productId});
}
