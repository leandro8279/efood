import 'package:efood/domain/repositories/coupon_repository.dart';
import 'package:efood/ui/coupon/coupon_viewmodel.dart';
import 'package:efood/utils/notifiers/auth_session_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:get/get.dart';

class CouponBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CouponViewModel>(
      () => CouponViewModel(
        couponRepository: Get.find<CouponRepository>(),
        authSessionNotifier: Get.find<AuthSessionNotifier>(),
       configNotifier:  Get.find<ConfigNotifier>()
      ),
    );
  }
}
