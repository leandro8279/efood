import 'package:dio/dio.dart';
import 'package:efood/config/constants.dart';
import 'package:efood/data/services/api/model/product/product_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'set_menu_api.g.dart';

@RestApi()
abstract class SetMenuApi {
  factory SetMenuApi(Dio dio) = _SetMenuApi;

  @GET(AppConstants.setMenuProductsUrl)
  Future<List<ProductApiModel>> getSetMenuList();
}
