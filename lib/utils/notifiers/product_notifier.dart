import 'package:efood/domain/models/product/product.dart';
import 'package:get/get.dart';

class ProductNotifier extends GetxController {
  final Rx<Product?> _product = Rx<Product?>(null);

  Rx<Product?> get product => _product;
}
