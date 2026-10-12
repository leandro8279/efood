import 'package:dio/dio.dart';
import 'package:efood/config/constants.dart';
import 'package:efood/data/services/api/mappers/mappers.dart';
import 'package:efood/data/services/api/product_api.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/domain/models/product/product_list.dart';
import 'package:efood/domain/repositories/product_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/result.dart';

class ProductRepositoryRemote({required final ProductApi _productApi}) implements ProductRepository {
  @override
  Future<Result<ProductList>> getLatestProductList({required int offset}) async {
    try {
      final productList = await _productApi.getLatestProductList(
        limit: AppConstants.productsPageLimit.toString(),
        offset: offset.toString(),
      );
      return Result.ok(productList.toDomain());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }

  @override
  Future<Result<ProductList>> getPopularProductList({required int offset, required String productType}) async {
    try {
      final productList = await _productApi.getPopularProductList(
        limit: AppConstants.productsPageLimit,
        offset: offset,
        productType: productType,
      );
      return Result.ok(productList.toDomain());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }

  @override
  Future<Result<Product>> getProductById({required int productId}) async {
    try {
      final product = await _productApi.getProductById(productId);
      return Result.ok(product.toDomain());
    } on DioException catch (e, st) {
      if (e.response?.statusCode == 404) {
        return Result.error(NotFoundException(cause: e, stackTrace: st));
      }
      return Result.error(e.toAppException(st));
    }
  }
}
