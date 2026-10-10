import 'package:efood/domain/models/category/category.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/repositories/category_repository.dart';
import 'package:efood/domain/repositories/config_repository.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class HomeViewModel({
  required final CategoryRepository _categoryRepository,
  required final ConfigRepository _configRepository,
}) extends GetxController {
  final Rx<Config?> _config = Rx<Config?>(null);
  final RxList<Category> _categories = <Category>[].obs;

  Config? get config => _config.value;
  List<Category> get categories => _categories;

  late final loadConfig = Command0<void>(_loadConfig);
  late final loadCategories = Command0<List<Category>>(_loadCategories);

  Future<Result<List<Category>>> _loadCategories() async {
    final result = await _categoryRepository.getCategories();

    return switch (result) {
      Ok<List<Category>>(:final value) => _setCategories(value),
      Error<List<Category>>(:final error) => Result.error(error),
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

    // ever(_config, (value) => print("$value has been changed (ever)"));
    // ever(_categories, (value) => print("$value has been changed (ever)"));
  }
}
