import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/utils/notifiers/cart_notifier.dart';
import 'package:get/get.dart';

class ProductNotifier extends GetxController {
  final Rx<Product?> _product = Rx<Product?>(null);
  final RxList<int> _variationIndex = <int>[0].obs;
  final RxList<bool> _addOnActiveList = <bool>[].obs;
  final RxList<int> _addOnQtyList = <int>[].obs;
  final RxInt _quantity = 1.obs;
  final RxInt _cartIndex = RxInt(-1);

  Rx<Product?> get product => _product;
  List<int> get variationIndex => _variationIndex;
  List<bool> get addOnActiveList => _addOnActiveList;
  List<int> get addOnQtyList => _addOnQtyList;
  RxInt get quantity => _quantity;
  RxInt get cartIndex => _cartIndex;

  void initData(Product product, Cart? cart) {
    _addOnQtyList.value = [];
    _variationIndex.value = [];
    _addOnActiveList.value = [];

    if (cart != null) {
      _quantity.value = cart.quantity;
      List<String> variationTypes = [];

      if (cart.variation.isNotEmpty && cart.variation[0]?.type != null) {
        variationTypes.addAll(cart.variation[0]!.type.split('-'));
      }

      int varIndex = 0;

      for (var choiceOption in product.choiceOptions) {
        if (choiceOption!.options.isEmpty) return;

        for (int index = 0; index < choiceOption.options.length; index++) {
          if (choiceOption.options[index].trim().replaceAll(' ', '') == variationTypes[varIndex].trim()) {
            _variationIndex.add(index);
            break;
          }
        }
        varIndex++;
      }

      List<int> addOnIdList = [];

      for (var addOnId in cart.addOnIds) {
        addOnIdList.add(addOnId.id);
      }

      for (var addOn in product.addOns) {
        if (addOnIdList.contains(addOn.id)) {
          _addOnActiveList.add(true);
          _addOnQtyList.add(cart.addOnIds[addOnIdList.indexOf(addOn.id)].quantity);
        } else {
          _addOnActiveList.add(false);
          _addOnQtyList.add(1);
        }
      }
    } else {
      _quantity.value = 1;

      for (var _ in product.choiceOptions) {
        variationIndex.add(0);
      }

      for (var _ in product.addOns) {
        _addOnActiveList.add(false);
        _addOnQtyList.add(1);
      }

      setExistInCart(product);
    }
  }

  int setExistInCart(Product product) {
    List<String> variationList = [];

    if (product.choiceOptions.isNotEmpty) {
      for (int index = 0; index < product.choiceOptions.length; index++) {
        variationList.add(product.choiceOptions[index]!.options[variationIndex[index]].replaceAll(' ', ''));
      }
    }

    String variationType = '';
    bool isFirst = true;

    for (var variation in variationList) {
      if (isFirst) {
        variationType = '$variationType$variation';
        isFirst = false;
      } else {
        variationType = '$variationType-$variation';
      }
    }

    final cartNotifier = Get.find<CartNotifier>();

    _cartIndex.value = cartNotifier.isExistInCart(product.id, variationType, false, null);

    if (_cartIndex.value != -1) {
      _quantity.value = cartNotifier.carts[_cartIndex.value].quantity;
      _addOnActiveList.value = [];
      _addOnQtyList.value = [];
      List<int> addOnIdList = [];

      for (var addOnId in cartNotifier.carts[cartIndex.value].addOnIds) {
        addOnIdList.add(addOnId.id);
      }

      for (var addOn in product.addOns) {
        if (addOnIdList.contains(addOn.id)) {
          _addOnActiveList.add(true);
          _addOnQtyList.add(cartNotifier.carts[cartIndex.value].addOnIds[addOnIdList.indexOf(addOn.id)].quantity);
        } else {
          _addOnActiveList.add(false);
          _addOnQtyList.add(1);
        }
      }
    }

    return _cartIndex.value;
  }
}
