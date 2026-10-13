import 'package:dio/dio.dart';
import 'package:efood/data/services/api/category_api.dart';
import 'package:efood/data/services/api/mappers/mappers.dart';
import 'package:efood/domain/models/category/category.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/domain/repositories/category_repository.dart';
import 'package:efood/utils/result.dart';

class CategoryRepositoryRemote({required final CategoryApi _categoryApi}) implements CategoryRepository {
  @override
  Future<Result<List<Category>>> getCategories() async {
    try {
      final categories = await _categoryApi.getCategories();
      return Result.ok(categories.map((s) => s.toDomain()).toList());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }

  @override
  Future<Result<List<Category>>> getSubCategoryList(String categoryId) async {
    try {
      final categories = await _categoryApi.getSubCategoryList(categoryId);
      return Result.ok(categories.map((category) => category.toDomain()).toList());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }

  @override
  Future<Result<List<Product>>> getCategoryProductList(String categoryId, String type) async {
    try {
      final products = await _categoryApi.getCategoryProductList(categoryId, type);
      return Result.ok(products.map((product) => product.toDomain()).toList());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }
}
