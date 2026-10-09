import 'package:dio/dio.dart';
import 'package:efood/config/constants.dart';
import 'package:efood/data/services/api/model/category/category_list_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'category_api.g.dart';

@RestApi()
abstract class CategoryApi {
  factory CategoryApi(Dio dio) = _CategoryApi;

  @GET(AppConstants.categoriesUrl)
  Future<CategoryListApiModel> getCategories({
    @Header('X-localization') required String languageCode,
  });
}
