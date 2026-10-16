import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/ui/popular_item/popular_item_viewmodel.dart';
import 'package:get/get.dart';

class PropularItemBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PopularItemViewModel(productRepository: Get.find<ProductRepository>()));
  }
}
