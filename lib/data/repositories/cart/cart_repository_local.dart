import 'dart:async';
import 'dart:convert';

import 'package:efood/data/repositories/cart/cart_local_model.dart';
import 'package:efood/data/services/local/local.dart';
import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/domain/repositories/cart_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/result.dart';

class CartRepositoryLocal({required final SharedPreferencesService _sharedPreferencesService}) implements CartRepository {
  final StreamController<List<Cart>> _cartUpdates = StreamController<List<Cart>>.broadcast();
  List<Cart>? _cachedCartList;

  @override
  Result<List<Cart>> getCartList() {
    final cachedCartList = _cachedCartList;
    if (cachedCartList != null) {
      return Result.ok(cachedCartList);
    }

    try {
      final carts = _sharedPreferencesService.getStringList(StorageKeys.cartList) ?? const <String>[];
      final cartList = carts
          .map(
            (cart) => CartLocalModel.fromJson(jsonDecode(cart) as Map<String, dynamic>).toDomain(),
          )
          .toList();
      _cachedCartList = List<Cart>.unmodifiable(cartList);
      return Result.ok(_cachedCartList!);
    } catch (e, st) {
      return Result.error(StorageException(cause: e, stackTrace: st));
    }
  }

  @override
  Stream<List<Cart>> watchCartList() {
    return Stream<List<Cart>>.multi((controller) {
      final updatesSubscription = _cartUpdates.stream.listen(
        controller.add,
        onError: controller.addError,
      );
      controller.onCancel = updatesSubscription.cancel;

      switch (getCartList()) {
        case Ok<List<Cart>>(:final value):
          controller.add(value);
        case Error<List<Cart>>(:final error):
          controller.addError(error, error.stackTrace);
      }
    });
  }

  @override
  Future<Result<void>> addToCartList(List<Cart> cartProductList) async {
    try {
      final cartList = List<Cart>.unmodifiable(cartProductList);
      final carts = cartProductList
          .map((cart) => jsonEncode(CartLocalModel.fromDomain(cart).toJson()))
          .toList();
      final saved = await _sharedPreferencesService.setStringList(StorageKeys.cartList, carts);
      if (!saved) {
        return Result.error(StorageException(cause: StateError('Could not save the cart list.')));
      }

      _cachedCartList = cartList;
      _cartUpdates.add(cartList);
      return Result.done;
    } catch (e, st) {
      return Result.error(StorageException(cause: e, stackTrace: st));
    }
  }
}
