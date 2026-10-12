import 'package:efood/domain/models/banner/banner.dart';
import 'package:efood/domain/models/category/category.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/domain/models/product/product_list.dart';
import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/config/config_notifier.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class const PopularProductListParams({
  final bool reload = false,
  final String offset = '1',
  final String type = 'all',
  final bool isUpdate = false,
});

class HomeViewModel({
  required final ConfigNotifier _configNotifier,
  required final BannerRepository _bannerRepository,
  required final ProductRepository _productRepository,
  required final SetMenuRepository _setMenuRepository,
  required final CategoryRepository _categoryRepository,
}) extends GetxController {
  final _log = AppLogger('HomeViewModel');
  final RxList<Banner> _banners = <Banner>[].obs;
  final RxList<Category> _categories = <Category>[].obs;
  final RxList<Product> _latestProducts = <Product>[].obs;
  final RxList<Product> _popularProductList = <Product>[].obs;
  final RxList<Product> _setMenuProducts = <Product>[].obs;
  List<String> _latestOffsetList = [];
  List<String> _popularOffsetList = [];
  final RxInt latestOffset = 1.obs;
  final RxInt latestPageSize = 12.obs;
  final RxInt popularOffset = 1.obs;
  final RxInt popularPageSize = 12.obs;

  List<Banner> get banners => _banners;
  List<Category> get categories => _categories;
  Config? get config => _configNotifier.config.value;
  List<Product> get latestProducts => _latestProducts;
  List<Product> get popularProductList => _popularProductList;
  List<Product> get setMenuProducts => _setMenuProducts;

  bool isRestaurantOpenNow() => _configNotifier.isRestaurantOpenNow();
  void setLatestOffset(int value) => latestOffset.value = value;

  late final loadBanners = Command0<List<Banner>>(_loadBanners);
  late final loadSetMenu = Command0<List<Product>>(_loadSetMenu);
  late final loadCategories = Command0<List<Category>>(_loadCategories);
  late final getLatestProductList = Command1<void, (bool, String)>(
    (args) => _getLatestProductList(args.$1, args.$2),
  );
  late final getPopularProductList = Command1<void, PopularProductListParams>(
    (params) => _getPopularProductList(
      params.reload,
      params.offset,
      params.type,
      params.isUpdate,
    ),
  );

  Future<Result<void>> _getLatestProductList(bool reload, String _offset) async {
    final offset = int.tryParse(_offset);
    if (offset == null || offset < 1) {
      final error = ValidationException('O offset deve ser um número inteiro positivo.');
      _log.error('Offset inválido ao carregar os produtos mais recentes', error: error);
      return Result.error(error);
    }

    if (reload || _offset == '1') {
      latestOffset.value = 1;
      _latestOffsetList = [];
    }

    if (!_latestOffsetList.contains(_offset)) {
      _latestOffsetList = [];
      _latestOffsetList.add(_offset);
      final result = await _productRepository.getLatestProductList(offset: offset);

      return switch (result) {
        Ok<ProductList>(:final value) => _setLatestProducts(value, reload, _offset),
        Error<ProductList>(:final error) => _handleLoadError('Falha ao carregar produtos mais recentes', error),
      };
    }

    _log.info('Produtos mais recentes já carregados para o offset $_offset');
    return Result.done;
  }

  Future<Result<void>> _getPopularProductList(
    bool reload,
    String _offset,
    String type,
    bool isUpdate,
  ) async {
    final offset = int.tryParse(_offset);
    if (offset == null || offset < 1) {
      final error = ValidationException('O offset deve ser um número inteiro positivo.');
      _log.error('Offset inválido ao carregar produtos populares', error: error);
      return Result.error(error);
    }

    if (reload || _offset == '1') {
      popularOffset.value = 1;
      _popularOffsetList = [];
      _popularProductList.clear();
    }

    if (!_popularOffsetList.contains(_offset)) {
      _popularOffsetList = [];
      _popularOffsetList.add(_offset);
      _log.info('Carregando produtos populares para offset $_offset e tipo $type');
      final result = await _productRepository.getPopularProductList(
        offset: offset,
        productType: type,
      );

      return switch (result) {
        Ok<ProductList>(:final value) => _setPopularProducts(value, reload, _offset, isUpdate),
        Error<ProductList>(:final error) => _handleLoadError('Falha ao carregar produtos populares', error),
      };
    }

    _log.info('Produtos populares já carregados para o offset $_offset');
    return Result.done;
  }

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

  Future<Result<List<Banner>>> _loadBanners() async {
    _log.info('Carregando banners');
    final result = await _bannerRepository.getBanners();

    return switch (result) {
      Ok<List<Banner>>(:final value) => _setBanners(value),
      Error<List<Banner>>(:final error) => _handleLoadError('Falha ao carregar banners', error),
    };
  }

  Result<List<Category>> _setCategories(List<Category> categories) {
    _categories.value = categories;
    _log.info('Categorias carregadas: ${_categories.length}');

    return Result.ok(categories);
  }

  Result<List<Product>> _setSetMenuList(List<Product> products) {
    _setMenuProducts.value = products;
    _log.info('Produtos do menu carregados: ${_setMenuProducts.length}');

    return Result.ok(products);
  }

  Result<void> _setLatestProducts(ProductList productList, bool reload, String _offset) {
    if (reload || _offset == '1') {
      _latestProducts.clear();
    }
    _latestProducts.addAll(productList.products);
    latestOffset.value = productList.offset;
    latestPageSize.value = productList.totalSize;
    _log.info('Produtos mais recentes carregados: ${_latestProducts.length}');

    return Result.done;
  }

  Result<void> _setPopularProducts(
    ProductList productList,
    bool reload,
    String _offset,
    bool isUpdate,
  ) {
    if (reload || _offset == '1') {
      _popularProductList.clear();
    }
    _popularProductList.addAll(productList.products);
    popularOffset.value = productList.offset;
    popularPageSize.value = productList.totalSize;
    if (isUpdate) {
      update();
    }
    _log.info('Produtos populares carregados: ${_popularProductList.length}');

    return Result.done;
  }

  Result<List<Banner>> _setBanners(List<Banner> banners) {
    _banners.value = banners;
    _log.info('Banners carregados: ${_banners.length}');

    return Result.ok(banners);
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
    loadBanners.execute();
    getLatestProductList.execute((true, '1'));
  }
}
