import 'package:efood/domain/repositories/set_menu_repository.dart';
import 'package:efood/ui/set_menu/set_menu_viewmodel.dart';
import 'package:efood/utils/notifiers/cart_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:get/get.dart';

class SetMenuBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetMenuViewModel>(
      () => SetMenuViewModel(
        cartNotifier: Get.find<CartNotifier>(),
        configNotifier: Get.find<ConfigNotifier>(),
        setMenuRepository: Get.find<SetMenuRepository>(),
      ),
    );
  }
}
