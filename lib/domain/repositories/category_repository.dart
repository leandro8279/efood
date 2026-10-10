import 'package:efood/domain/models/category/category.dart';
import 'package:efood/utils/result.dart';

abstract interface class CategoryRepository {
  Future<Result<List<Category>>> getCategories();
}
