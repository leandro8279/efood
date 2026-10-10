import 'package:dio/dio.dart';
import 'package:efood/data/services/api/banner_api.dart';
import 'package:efood/data/services/api/mappers/banner_api_model_mapper.dart';
import 'package:efood/data/services/api/mappers/dio_exception_mapper.dart';
import 'package:efood/domain/models/banner/banner.dart';
import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/utils/result.dart';

class BannerRepositoryRemote({required final BannerApi _bannerApi}) implements BannerRepository {
  @override
  Future<Result<List<Banner>>> getBanners() async {
    try {
      final banners = await _bannerApi.getBanners();
      return Result.ok(banners.map((s) => s.toDomain()).toList());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }
}
