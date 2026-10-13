import 'package:efood/domain/repositories/category_repository.dart';
import 'package:efood/ui/category/category_viewmodel.dart';
import 'package:get/get.dart';

class CategoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryViewModel>(
      () => CategoryViewModel(categoryRepository: Get.find<CategoryRepository>()),
    );
  }
}
