import 'package:efood/domain/models/category/category_page.dart';
import 'package:efood/utils/result.dart';

abstract interface class CategoryRepository {
  Future<Result<CategoryPage>> getCategories({required String languageCode});
}
