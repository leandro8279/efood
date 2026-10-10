import 'package:efood/domain/models/product/product.dart';
import 'package:efood/utils/result.dart';

abstract interface class SetMenuRepository {
  Future<Result<List<Product>>> getSetMenuList();
}
