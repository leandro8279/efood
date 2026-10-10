import 'package:efood/domain/models/banner/banner.dart';
import 'package:efood/utils/result.dart';

abstract interface class BannerRepository {
  Future<Result<List<Banner>>> getBanners();
}
