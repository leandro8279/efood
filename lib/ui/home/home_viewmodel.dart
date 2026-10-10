import 'package:efood/domain/models/category/category.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/domain/repositories/category_repository.dart';
import 'package:efood/domain/repositories/set_menu_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/config/config_notifier.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class HomeViewModel({
  required final CategoryRepository _categoryRepository,
  required final ConfigNotifier _configNotifier,
  required final SetMenuRepository _setMenuRepository,
}) extends GetxController {
  final _log = AppLogger('HomeViewModel');
  final RxList<Category> _categories = <Category>[].obs;
  final RxList<Product> _setMenuProducts = <Product>[].obs;

  Config? get config => _configNotifier.config.value;
  List<Category> get categories => _categories;
  List<Product> get setMenuProducts => _setMenuProducts;

  late final loadCategories = Command0<List<Category>>(_loadCategories);
  late final loadSetMenu = Command0<List<Product>>(_loadSetMenu);

  Future<Result<List<Category>>> _loadCategories() async {
    _log.info('Carregando categorias');
    final result = await _categoryRepository.getCategories();

    return switch (result) {
      Ok<List<Category>>(:final value) => _setCategories(value),
      Error<List<Category>>(:final error) => _handleLoadError('Falha ao carregar categorias', error),
    };
  }

  Future<Result<List<Product>>> _loadSetMenu() async {
    _log.info('Carregando produtos do menu');
    final result = await _setMenuRepository.getSetMenuList();

    return switch (result) {
      Ok<List<Product>>(:final value) => _setSetMenuList(value),
      Error<List<Product>>(:final error) => _handleLoadError('Falha ao carregar produtos do menu', error),
    };
  }

  Result<List<Category>> _setCategories(List<Category> categories) {
    _categories.value = categories;
    _log.info('Categorias carregadas: ${categories.length}');

    return Result.ok(categories);
  }

  Result<List<Product>> _setSetMenuList(List<Product> products) {
    _setMenuProducts.value = products;
    _log.info('Produtos do menu carregados: ${products.length}');

    return Result.ok(products);
  }

  Result<T> _handleLoadError<T>(String message, AppException error) {
    _log.error(message, error: error, stackTrace: error.stackTrace);
    return Result.error(error);
  }

  @override
  void onInit() {
    super.onInit();
    loadCategories.execute();
    loadSetMenu.execute();
  }
}
