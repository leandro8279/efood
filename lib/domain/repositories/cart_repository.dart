import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/utils/result.dart';

abstract interface class CartRepository {
  Result<List<Cart>> getCartList();

  Stream<List<Cart>> watchCartList();

  Future<Result<void>> addToCartList(List<Cart> cartProductList);
}
