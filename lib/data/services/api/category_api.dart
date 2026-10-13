import 'package:dio/dio.dart';
import 'package:efood/config/constants.dart';
import 'package:efood/data/services/api/model/category/category_api_model.dart';
import 'package:efood/data/services/api/model/product/product_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'category_api.g.dart';

@RestApi()
abstract class CategoryApi {
  factory CategoryApi(Dio dio) = _CategoryApi;

  @GET(AppConstants.categoriesUrl)
  Future<List<CategoryApiModel>> getCategories();

  @GET(AppConstants.subCategoriesUrl)
  Future<List<CategoryApiModel>> getSubCategoryList(@Path('categoryId') String categoryId);

  @GET(AppConstants.categoryProductsUrl)
  Future<List<ProductApiModel>> getCategoryProductList(
    @Path('categoryId') String categoryId,
    @Query('product_type') String type,
  );
}
