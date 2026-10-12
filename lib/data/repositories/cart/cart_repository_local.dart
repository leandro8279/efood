import 'dart:async';
import 'dart:convert';

import 'package:efood/data/services/local/local.dart';
import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/domain/repositories/cart_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/result.dart';
import "package:efood/data/services/local/mappers/cart_local_model_mapper.dart";

class CartRepositoryLocal({required final SharedPreferencesService _sharedPreferencesService})
    implements CartRepository {
  @override
  Result<List<Cart>> getCartList() {
    List<String> carts = [];
    try {
       if(_sharedPreferencesService.contains(StorageKeys.cartList))){
       carts = _sharedPreferencesService.getStringList(StorageKeys.cartList)!; 
      }
      final cartList = carts
        .map((s) => CartLocalModel.fromJson(
              jsonDecode(s) as Map<String, dynamic>,
            ).toDomain())
        .toList();
      return Result.ok(cartList);
    } catch (e, st) {
      return Result.error(StorageException(cause: e, stackTrace: st));
    }
  }

  @override
  Result<void> addToCartList(List<Cart> cartProductList) {
    try {
      final carts = cartProductList.map((cart) => jsonEncode(CartLocalModel.fromDomain(cart).toJson())).toList();
_sharedPreferencesService.setStringList(StorageKeys.cartList, carts);
      return Result.done;
    } catch (e, st) {
      return Result.error(StorageException(cause: e, stackTrace: st));
    }
  }
}
