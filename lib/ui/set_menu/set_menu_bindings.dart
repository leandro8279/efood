import 'package:efood/domain/repositories/set_menu_repository.dart';
import 'package:efood/ui/set_menu/set_menu_viewmodel.dart';
import 'package:get/get.dart';

class SetMenuBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetMenuViewModel>(
      () => SetMenuViewModel(setMenuRepository: Get.find<SetMenuRepository>()),
    );
  }
}
