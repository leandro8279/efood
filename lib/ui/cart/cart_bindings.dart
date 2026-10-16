import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/ui/cart/cart_viewmodel.dart';
import 'package:efood/utils/notifiers/cart_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:get/get.dart';

class CartBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CartViewModel(
        cartNotifier: Get.find<CartNotifier>(),
        configNotifier: Get.find<ConfigNotifier>(),
        couponRepository: Get.find<CouponRepository>(),
      ),
    );
  }
}
