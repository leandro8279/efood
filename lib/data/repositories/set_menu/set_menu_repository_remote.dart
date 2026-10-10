import 'package:dio/dio.dart';
import 'package:efood/data/services/api/mappers/mappers.dart';
import 'package:efood/data/services/api/set_menu_api.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/domain/repositories/set_menu_repository.dart';
import 'package:efood/utils/result.dart';

class SetMenuRepositoryRemote({required final SetMenuApi _setMenuApi}) implements SetMenuRepository {
  @override
  Future<Result<List<Product>>> getSetMenuList() async {
    try {
      final products = await _setMenuApi.getSetMenuList();
      return Result.ok(products.map((product) => product.toDomain()).toList());
    } on DioException catch (e, st) {
      return Result.error(e.toAppException(st));
    }
  }
}
