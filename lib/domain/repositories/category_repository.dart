import 'package:efood/domain/models/category/category.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/utils/result.dart';

abstract interface class CategoryRepository {
  Future<Result<List<Category>>> getCategories();
  Future<Result<List<Category>>> getSubCategoryList(String categoryId);
  Future<Result<List<Product>>> getCategoryProductList(String categoryId, String type);
}
