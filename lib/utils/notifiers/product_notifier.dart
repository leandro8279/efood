import 'package:efood/domain/models/product/product.dart';
import 'package:get/get.dart';

class ProductNotifier extends GetxController {
  final Rx<Product?> _product = Rx<Product?>(null);
  final RxList<int> _variationIndex = <int>[0].obs;
  final RxList<bool> _addOnActiveList = <bool>[].obs;
  final RxList<int> _addOnQtyList = <int>[].obs;
  final RxInt _quantity = 1.obs;

  Rx<Product?> get product => _product;
  List<int> get variationIndex => _variationIndex;
  List<bool> get addOnActiveList => _addOnActiveList;
  List<int> get addOnQtyList => _addOnQtyList;
  int get quantity => _quantity.value;
}
