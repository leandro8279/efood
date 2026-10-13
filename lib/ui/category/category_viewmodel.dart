import 'package:efood/domain/models/category/category.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/domain/repositories/category_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/notifiers/product_notifier.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class const CategoryProductListParams({required final String categoryId, final String type = 'all'});

class CategoryViewModel({
  required final ProductNotifier _productNotifier,
  required final CategoryRepository _categoryRepository,
}) extends GetxController {
  final _log = AppLogger('CategoryViewModel');
  final RxString _selectedSubCategoryId = "".obs;
  final RxList<Category> _categories = <Category>[].obs;
  final RxList<Category> _subCategories = <Category>[].obs;
  final RxList<Product> _categoryProducts = <Product>[].obs;

  List<Category> get categories => _categories;
  List<Category> get subCategories => _subCategories;
  List<Product> get categoryProducts => _categoryProducts;
  String get selectedSubCategoryId => _selectedSubCategoryId.value;
  List<String> get productTypeList => _productNotifier.productTypeList;
  bool get isLoading => loadCategories.running.value || loadSubCategories.running.value;

  late final loadCategories = Command0<List<Category>>(_loadCategories);
  late final loadSubCategories = Command1<List<Category>, String>(_loadSubCategories);
  late final loadCategoryProductList = Command1<List<Product>, CategoryProductListParams>(_loadCategoryProductList);

  Future<Result<List<Category>>> _loadCategories() async {
    _log.info('Carregando categorias');
    final result = await _categoryRepository.getCategories();

    return switch (result) {
      Ok<List<Category>>(:final value) => _setCategories(value),
      Error<List<Category>>(:final error) => _handleLoadError(error),
    };
  }

  Future<Result<List<Category>>> _loadSubCategories(String categoryId) async {
    _log.info('Carregando subcategorias da categoria $categoryId');
    final result = await _categoryRepository.getSubCategoryList(categoryId);

    return switch (result) {
      Ok<List<Category>>(:final value) => _setSubCategories(value),
      Error<List<Category>>(:final error) => _handleLoadError(error),
    };
  }

  Future<Result<List<Product>>> _loadCategoryProductList(CategoryProductListParams params) async {
    _log.info('Carregando produtos da categoria ${params.categoryId} com tipo ${params.type}');
    _selectedSubCategoryId.value = params.categoryId;
    final result = await _categoryRepository.getCategoryProductList(params.categoryId, params.type);

    return switch (result) {
      Ok<List<Product>>(:final value) => _setCategoryProducts(value),
      Error<List<Product>>(:final error) => _handleLoadError(error),
    };
  }

  Result<List<Category>> _setCategories(List<Category> categories) {
    _categories.assignAll(categories);
    _log.info('Categorias carregadas: ${_categories.length}');
    return Result.ok(categories);
  }

  Result<List<Product>> _setCategoryProducts(List<Product> products) {
    _categoryProducts.assignAll(products);
    _log.info('Produtos da categoria carregados: ${_categoryProducts.length}');
    return Result.ok(products);
  }

  Result<List<Category>> _setSubCategories(List<Category> categories) {
    _subCategories.assignAll(categories);
    _log.info('Subcategorias carregadas: ${_subCategories.length}');
    return Result.ok(categories);
  }

  Result<T> _handleLoadError<T>(AppException error) {
    _log.error('Falha ao carregar categorias', error: error, stackTrace: error.stackTrace);
    return Result.error(error);
  }
}
