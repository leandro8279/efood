import 'package:efood/domain/models/category/category.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/domain/repositories/category_repository.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/domain/repositories/set_menu_repository.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class HomeViewModel({
  required final CategoryRepository _categoryRepository,
  required final ConfigRepository _configRepository,
  required final SetMenuRepository _setMenuRepository,
}) extends GetxController {
  final Rx<Config?> _config = Rx<Config?>(null);
  final RxList<Category> _categories = <Category>[].obs;
  final RxList<Product> _setMenuProducts = <Product>[].obs;

  Config? get config => _config.value;
  List<Category> get categories => _categories;
  List<Product> get setMenuProducts => _setMenuProducts;

  late final loadConfig = Command0<void>(_loadConfig);
  late final loadCategories = Command0<List<Category>>(_loadCategories);
  late final loadSetMenu = Command0<List<Product>>(_loadSetMenu);

  Future<Result<List<Category>>> _loadCategories() async {
    final result = await _categoryRepository.getCategories();

    return switch (result) {
      Ok<List<Category>>(:final value) => _setCategories(value),
      Error<List<Category>>(:final error) => Result.error(error),
    };
  }

  Future<Result<List<Product>>> _loadSetMenu() async {
    final result = await _setMenuRepository.getSetMenuList();

    return switch (result) {
      Ok<List<Product>>(:final value) => _setMenuProducts.value = value,
      Error<List<Product>>(:final error) => Result.error(error),
    };
  }

  Future<Result<void>> _loadConfig() async {
    final result = await _configRepository.getConfig();

    switch (result) {
      case Ok<Config>(:final value):
        _config.value = value;
        return Result.ok(null);
      case Error<Config>(:final error):
        return Result.error(error);
    }
  }

  Result<List<Category>> _setCategories(List<Category> categories) {
    _categories.value = categories;

    return Result.ok(categories);
  }

  @override
  void onInit() {
    super.onInit();
    loadConfig.execute();
    loadCategories.execute();
    loadSetMenu.execute();

    // ever(_config, (value) => print("$value has been changed (ever)"));
    // ever(_categories, (value) => print("$value has been changed (ever)"));
  }
}
