import 'dart:async';

import 'package:efood/domain/models/coupon/coupon.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/repositories/coupon_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/notifiers/auth_session_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class CouponViewModel({
  required final ConfigNotifier _configNotifier,
  required final CouponRepository _couponRepository,
  required final AuthSessionNotifier _authSessionNotifier,
}) extends GetxController {
  final _log = AppLogger('CouponViewModel');
  final RxList<Coupon> _coupons = <Coupon>[].obs;

  List<Coupon> get coupons => _coupons;
  Config get config => _configNotifier.config.value!;
  bool get isSignedIn => _authSessionNotifier.isSignedIn;

  late final loadCoupons = Command0<List<Coupon>>(_loadCoupons);

  Future<Result<List<Coupon>>> _loadCoupons() async {
    _log.info('Carregando cupons');
    final result = await _couponRepository.getCouponList();

    return switch (result) {
      Ok<List<Coupon>>(:final value) => _setCoupons(value),
      Error<List<Coupon>>(:final error) => _handleLoadError(error),
    };
  }

  Result<List<Coupon>> _setCoupons(List<Coupon> coupons) {
    _coupons.assignAll(coupons);
    _log.info('Cupons carregados: ${_coupons.length}');
    return Result.ok(coupons);
  }

  Result<List<Coupon>> _handleLoadError(AppException error) {
    _log.error('Falha ao carregar cupons', error: error, stackTrace: error.stackTrace);
    return Result.error(error);
  }

  @override
  void onInit() {
    super.onInit();
    if (isSignedIn) {
      unawaited(loadCoupons.execute());
    }
  }
}
