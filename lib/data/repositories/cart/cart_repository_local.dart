import 'dart:convert';

import 'package:efood/data/repositories/cart/cart_local_model.dart';
import 'package:efood/data/services/local/local.dart';
import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/domain/repositories/cart_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/result.dart';

class CartRepositoryLocal({required final SharedPreferencesService _sharedPreferencesService}) implements CartRepository {
  @override
  Result<List<Cart>> getCartList() {
    try {
      final carts = _sharedPreferencesService.getStringList(StorageKeys.cartList) ?? const <String>[];
      final cartList = carts
          .map(
            (cart) => CartLocalModel.fromJson(jsonDecode(cart) as Map<String, dynamic>).toDomain(),
          )
          .toList();
      return Result.ok(cartList);
    } catch (e, st) {
      return Result.error(StorageException(cause: e, stackTrace: st));
    }
  }

  @override
  Future<Result<void>> addToCartList(List<Cart> cartProductList) async {
    try {
      final carts = cartProductList
          .map((cart) => jsonEncode(CartLocalModel.fromDomain(cart).toJson()))
          .toList();
      final saved = await _sharedPreferencesService.setStringList(StorageKeys.cartList, carts);
      if (!saved) {
        return Result.error(StorageException(cause: StateError('Could not save the cart list.')));
      }
      return Result.done;
    } catch (e, st) {
      return Result.error(StorageException(cause: e, stackTrace: st));
    }
  }
}
