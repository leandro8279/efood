import 'package:dio/dio.dart';
import 'package:efood/config/constants.dart';
import 'package:efood/data/services/api/model/product/product_api_model.dart';
import 'package:efood/data/services/api/model/product/product_list_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'product_api.g.dart';

@RestApi()
abstract class ProductApi {
  factory ProductApi(Dio dio) = _ProductApi;

  @GET(AppConstants.latestProductsUrl)
  Future<ProductListApiModel> getLatestProductList({
    @Query('limit') required int limit,
    @Query('offset') required int offset,
  });

  @GET(AppConstants.popularProductsUrl)
  Future<ProductListApiModel> getPopularProductList({
    @Query('limit') required int limit,
    @Query('offset') required int offset,
    @Query('product_type') required String productType,
  });

  @GET(AppConstants.productDetailsUrl)
  Future<ProductApiModel> getProductById(@Path('productId') int productId);
}
