import 'package:efood/domain/models/category/category.dart';
import 'package:efood/domain/models/category/category_page.dart';
import 'package:efood/domain/repositories/category_repository.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class HomeViewModel({
  required final CategoryRepository _categoryRepository,
}) extends GetxController {
  final RxList<Category> _categories = <Category>[].obs;

  List<Category> get categories => _categories;

  late final loadCategories = Command0<CategoryPage>(_loadCategories);

  Future<Result<CategoryPage>> _loadCategories() async {
    final languageCode = Get.locale?.languageCode ?? 'pt';
    final result = await _categoryRepository.getCategories(
      languageCode: languageCode,
    );

    return switch (result) {
      Ok<CategoryPage>(:final value) => _setCategories(value),
      Error<CategoryPage>(:final error) => Result.error(error),
    };
  }

  Result<CategoryPage> _setCategories(CategoryPage page) {
    _categories.assignAll(page.categories);
    return Result.ok(page);
  }

  @override
  void onInit() {
    super.onInit();
    loadCategories.execute();
  }
}
