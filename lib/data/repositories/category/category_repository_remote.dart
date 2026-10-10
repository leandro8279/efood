import 'package:dio/dio.dart';
import 'package:efood/data/services/api/category_api.dart';
import 'package:efood/data/services/api/mappers/mappers.dart';
import 'package:efood/domain/models/category/category.dart';
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
}
