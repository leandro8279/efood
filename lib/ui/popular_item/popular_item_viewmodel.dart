import 'package:efood/domain/models/product/product.dart';
import 'package:efood/domain/models/product/product_list.dart';
import 'package:efood/domain/repositories/repositories.dart';
import 'package:efood/ui/home/home_viewmodel.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class PopularItemViewModel({required final ProductRepository _productRepository}) extends GetxController {
  final _log = AppLogger('PopularItemViewmodel');

  final RxInt _offset = 1.obs;
  final RxInt _totalSize = 0.obs;
  final RxList<Product> _products = <Product>[].obs;

  // Páginas carregadas com sucesso (evita requisição duplicada)
  final Set<int> _loadedPages = {};

  String _type = 'all';
  final List<String> _productTypeList = ['all', 'non_veg', 'veg'];

  String get type => _type;
  int get offset => _offset.value;
  int get totalSize => _totalSize.value;
  List<Product> get products => _products;
  List<String> get productTypeList => _productTypeList;

  /// Ainda há itens a buscar no servidor?
  bool get hasMore => _products.length < _totalSize.value;

  late final loadProducts = Command1<void, PopularProductListParams>((params) => _loadProducts(params));

  @override
  void onInit() {
    super.onInit();
    refreshProducts();
  }

  Future<void> refreshProducts() {
    return loadProducts.execute(PopularProductListParams(reload: true, offset: '1', type: _type, isUpdate: false));
  }

  Future<void> loadNextPage() async {
    if (loadProducts.running.value || !hasMore) return;

    await loadProducts.execute(
      PopularProductListParams(reload: false, offset: (_offset.value + 1).toString(), type: _type, isUpdate: false),
    );
  }

  Future<Result<void>> _loadProducts(PopularProductListParams params) async {
    final page = int.tryParse(params.offset) ?? 1;

    if (params.reload || page == 1) {
      _loadedPages.clear();
      _products.clear();
      _offset.value = 1;
      _totalSize.value = 0;
    }

    if (_loadedPages.contains(page)) {
      _log.info('Página $page já carregada');
      return Result.done;
    }

    _log.info('Carregando produtos populares: página $page, tipo ${params.type}');

    final result = await _productRepository.getPopularProductList(offset: page, productType: params.type);

    return switch (result) {
      Ok<ProductList>(:final value) => _setProducts(value, page),
      Error<ProductList>(:final error) => _handleLoadError('Falha ao carregar produtos populares', error),
    };
  }

  Result<void> _setProducts(ProductList productList, int page) {
    _loadedPages.add(page); // só marca como carregada após sucesso
    _products.addAll(productList.products);
    _offset.value = productList.offset; // servidor é a fonte da verdade
    _totalSize.value = productList.totalSize;

    _log.info('Produtos carregados: ${_products.length}/${_totalSize.value}');
    return Result.done;
  }

  void setType(String value) => _type = value;

  Result<T> _handleLoadError<T>(String message, AppException error) {
    _log.error(message, error: error, stackTrace: error.stackTrace);
    return Result.error(error);
  }
}
