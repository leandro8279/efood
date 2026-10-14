import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/domain/repositories/cart_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/notifiers/auth_session_notifier.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class CartNotifier({
  required final AuthSessionNotifier _authSessionNotifier,
  required final CartRepository _cartRepository,
}) extends GetxController {
  final _log = AppLogger('CartNotifier');
  final RxDouble _amount = 0.0.obs;
  final RxBool _isCartUpdate = false.obs;
  final RxList<Cart> _carts = <Cart>[].obs;

  List<Cart> get carts => _carts;
  double get amount => _amount.value;
  bool get isCartUpdate => _isCartUpdate.value;
  bool get isSignedIn => _authSessionNotifier.isSignedIn;

  int isExistInCart(int productId, String variationType, bool isUpdate, int? cartIndex) {
    for (var index = 0; index < _carts.length; index++) {
      final cart = _carts[index];
      if (cart.product.id == productId && _matchesVariationType(cart, variationType)) {
        if (isUpdate && index == cartIndex) {
          return -1;
        }
        return index;
      }
    }
    return -1;
  }

  int? getCartProductIndex(Cart cartModel) {
    for (var index = 0; index < _carts.length; index++) {
      final cart = _carts[index];
      if (cart.product.id == cartModel.product.id && _hasMatchingVariation(cart, cartModel)) {
        return index;
      }
    }
    return null;
  }

  int? getCartIndex(Product product) {
    for (var index = 0; index < _carts.length; index++) {
      if (_carts[index].product.id == product.id) {
        return index;
      }
    }
    return null;
  }

  bool _matchesVariationType(Cart cart, String variationType) =>
      cart.variation.isEmpty || cart.variation.first?.type == variationType;

  bool _hasMatchingVariation(Cart cart, Cart cartModel) {
    if (cart.variation.isEmpty) {
      return true;
    }
    if (cartModel.variation.isEmpty) {
      return false;
    }

    final cartVariationType = cart.variation.first?.type;
    final modelVariationType = cartModel.variation.first?.type;
    return cartVariationType != null && cartVariationType == modelVariationType;
  }

  void getCartData() {
    _carts.clear();
    _amount.value = 0.0;

    switch (_cartRepository.getCartList()) {
      case Ok<List<Cart>>(:final value):
        _setCartData(value);
      case Error<List<Cart>>(:final error):
        _log.error('Falha ao carregar o carrinho', error: error, stackTrace: error.stackTrace);
    }
  }

  Future<Result<void>> addToCart(Cart cartModel, int? index) async {
    final updatedCarts = List<Cart>.of(_carts);

    if (index != null && index != -1) {
      if (index < 0 || index >= updatedCarts.length) {
        return Result.error(ValidationException('Índice inválido para atualizar o carrinho.'));
      }
      updatedCarts[index] = cartModel;
    } else {
      updatedCarts.add(cartModel);
    }

    return _saveCartList(updatedCarts);
  }

  Future<Result<void>> removeFromCart(int index) async {
    if (index < 0 || index >= _carts.length) {
      return Result.error(ValidationException('Índice inválido para remover item do carrinho.'));
    }

    final updatedCarts = List<Cart>.of(_carts)..removeAt(index);
    return _saveCartList(updatedCarts);
  }

  Future<Result<void>> removeAddOn(int index, int addOnIndex) async {
    if (index < 0 || index >= _carts.length) {
      return Result.error(ValidationException('Índice inválido para remover adicional do carrinho.'));
    }

    final cart = _carts[index];
    if (addOnIndex < 0 || addOnIndex >= cart.addOnIds.length) {
      return Result.error(ValidationException('Índice inválido para remover adicional do carrinho.'));
    }

    final updatedAddOns = List<CartAddOn>.of(cart.addOnIds)..removeAt(addOnIndex);
    return addToCart(_copyCart(cart, addOnIds: updatedAddOns), index);
  }

  Future<Result<void>> clearCartList() async => _saveCartList(<Cart>[]);

  Future<Result<void>> _saveCartList(List<Cart> updatedCarts) async {
    _isCartUpdate.value = true;
    try {
      final result = await _cartRepository.addToCartList(updatedCarts);
      switch (result) {
        case Ok<void>():
          _setCartData(updatedCarts);
        case Error<void>(:final error):
          _log.error('Falha ao salvar o carrinho', error: error, stackTrace: error.stackTrace);
      }
      return result;
    } finally {
      _isCartUpdate.value = false;
    }
  }

  Future<Result<void>> setQuantity({
    required bool isIncrement,
    required Cart cart,
    required int productIndex,
    required bool fromProductView,
  }) async {
    final index = fromProductView ? productIndex : _carts.indexOf(cart);
    if (index < 0 || index >= _carts.length) {
      return Result.error(ValidationException('Índice inválido para alterar a quantidade do carrinho.'));
    }

    final currentCart = _carts[index];
    final updatedCart = _copyCart(currentCart, quantity: currentCart.quantity + (isIncrement ? 1 : -1));

    return addToCart(updatedCart, index);
  }

  Cart _copyCart(Cart cart, {int? quantity, List<CartAddOn>? addOnIds}) => Cart(
    price: cart.price,
    discountedPrice: cart.discountedPrice,
    variation: cart.variation,
    discountAmount: cart.discountAmount,
    quantity: quantity ?? cart.quantity,
    taxAmount: cart.taxAmount,
    addOnIds: addOnIds ?? cart.addOnIds,
    product: cart.product,
  );

  void _setCartData(List<Cart> carts) {
    _carts.assignAll(carts);
    _amount.value = carts.fold(0.0, (amount, cart) => amount + (cart.discountedPrice * cart.quantity));
  }

  @override
  void onInit() {
    super.onInit();
    getCartData();
  }
}
