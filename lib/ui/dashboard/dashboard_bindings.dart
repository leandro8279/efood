import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/ui/dashboard/dashboard_viewmodel.dart';
import 'package:efood/ui/home/home_viewmodel.dart';
import 'package:efood/utils/config/config_notifier.dart';
import 'package:get/get.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardViewModel());
    Get.put<HomeViewModel>(
      HomeViewModel(
        configNotifier: Get.find<ConfigNotifier>(),
        bannerRepository: Get.find<BannerRepository>(),
        setMenuRepository: Get.find<SetMenuRepository>(),
        categoryRepository: Get.find<CategoryRepository>(),
      ),
    );
  }
}
