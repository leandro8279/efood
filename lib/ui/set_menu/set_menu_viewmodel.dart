import 'dart:async';

import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/product/product.dart';
import 'package:efood/domain/repositories/set_menu_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/notifiers/cart_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class SetMenuViewModel({
  required final CartNotifier _cartNotifier,
  required final ConfigNotifier _configNotifier,
  required final SetMenuRepository _setMenuRepository,
}) extends GetxController {
  final _log = AppLogger('SetMenuViewModel');
  final RxList<Product> _setMenuProducts = <Product>[].obs;

  CartNotifier get cartNotifier => _cartNotifier;
  bool get isLoading => loadSetMenu.running.value;
  Config get config => _configNotifier.config.value!;
  List<Product> get setMenuProducts => _setMenuProducts;

  late final loadSetMenu = Command0<List<Product>>(_loadSetMenu);

  Future<Result<List<Product>>> _loadSetMenu() async {
    _log.info('Carregando produtos do menu');
    final result = await _setMenuRepository.getSetMenuList();

    return switch (result) {
      Ok<List<Product>>(:final value) => _setSetMenuList(value),
      Error<List<Product>>(:final error) => _handleLoadError(error),
    };
  }

  Result<List<Product>> _setSetMenuList(List<Product> products) {
    _setMenuProducts.assignAll(products);
    _log.info('Produtos do menu carregados: ${_setMenuProducts.length}');
    return Result.ok(products);
  }

  Result<List<Product>> _handleLoadError(AppException error) {
    _log.error('Falha ao carregar produtos do menu', error: error, stackTrace: error.stackTrace);
    return Result.error(error);
  }

  @override
  void onInit() {
    super.onInit();
    unawaited(loadSetMenu.execute());
  }
}
