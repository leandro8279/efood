import 'package:efood/domain/repositories/category_repository.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/ui/dashboard/dashboard_viewmodel.dart';
import 'package:efood/ui/home/home_viewmodel.dart';
import 'package:get/get.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardViewModel());
    Get.put<HomeViewModel>(
      HomeViewModel(categoryRepository: Get.find<CategoryRepository>(), configRepository: Get.find<ConfigRepository>()),
    );
  }
}
