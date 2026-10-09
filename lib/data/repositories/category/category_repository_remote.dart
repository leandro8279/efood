import 'package:dio/dio.dart';
import 'package:efood/data/services/api/category_api.dart';
import 'package:efood/data/services/api/mappers/mappers.dart';
import 'package:efood/domain/models/category/category_page.dart';
import 'package:efood/domain/repositories/category_repository.dart';
import 'package:efood/utils/result.dart';

class CategoryRepositoryRemote({required final CategoryApi _categoryApi})
    implements CategoryRepository {
  @override
  Future<Result<CategoryPage>> getCategories({
    required String languageCode,
  }) async {
    try {
      final categories = await _categoryApi.getCategories(
        languageCode: languageCode,
      );
      return Result.ok(categories.toDomain());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }
}
