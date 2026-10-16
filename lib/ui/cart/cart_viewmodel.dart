import 'package:efood/domain/models/cart/cart.dart';
import 'package:efood/domain/models/config/config.dart';
import 'package:efood/domain/models/coupon/coupon.dart';
import 'package:efood/domain/repositories/coupon_repository.dart';
import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/command.dart';
import 'package:efood/utils/logging/app_logger.dart';
import 'package:efood/utils/notifiers/cart_notifier.dart';
import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:efood/utils/result.dart';
import 'package:get/get.dart';

class CartViewModel({
  required final ConfigNotifier _configNotifier,
  required final CartNotifier _cartNotifier,
  required final CouponRepository _couponRepository,
}) extends GetxController {
  final _log = AppLogger('CartViewModel');
  final Rx<Coupon?> _coupon = Rx<Coupon?>(null);
  final RxDouble _discount = RxDouble(0.0);
  final RxString _code = RxString("");
  final RxString _orderType = RxString('delivery');

  String get code => _code.value;
  Coupon? get coupon => _coupon.value;
  double get discount => _discount.value;
  String get orderType => _orderType.value;
  List<Cart> get carts => _cartNotifier.carts;
  Config get config => _configNotifier.config.value!;
  bool get selfPickup => _configNotifier.config.value!.selfPickup;
  bool get homeDelivery => _configNotifier.config.value!.homeDelivery;
  bool get kmWiseCharge => _configNotifier.config.value!.deliveryManagement.status == 1;

  late final applyCoupon = Command1<double, (String, double)>((args) => _applyCoupon(args.$1, args.$2));

  void removeCouponData() {
    _coupon.value = null;
    _discount.value = 0.0;
    _code.value = "";
  }

  Future<Result<double>> _applyCoupon(String couponCode, double order) async {
    final normalizedCode = couponCode.trim();

    _log.info('Validando cupom');
    final result = await _couponRepository.applyCoupon(normalizedCode);

    return switch (result) {
      Ok<Coupon>(:final value) => _setCoupon(value, order),
      Error<Coupon>(:final error) => _handleApplyCouponError(error),
    };
  }

  Result<double> _setCoupon(Coupon coupon, double order) {
    _coupon.value = coupon;
    _code.value = coupon.code;

    if (coupon.minPurchase != null && coupon.minPurchase <= order) {
      if (coupon.discountType == 'percent') {
        if (coupon.maxDiscount != null && coupon.maxDiscount != 0) {
          _discount.value = (coupon.discount * order / 100) < coupon.maxDiscount ? (coupon.discount * order / 100) : coupon.maxDiscount;
        } else {
          _discount.value = coupon.discount * order / 100;
        }
      } else {
        if (coupon.maxDiscount != null) {
          _discount.value = coupon.discount;
        }
        _discount.value = coupon.discount;
      }
    } else {
      _discount.value = 0.0;
    }

    return Result.ok(_discount.value);
  }

  Result<double> _handleApplyCouponError(AppException error) {
    _log.error('Falha ao aplicar cupom', error: error, stackTrace: error.stackTrace);
    _discount.value = 0.0;
    return Result.error(error);
  }

  void setOrderType(String value) => _orderType.value = value;

  @override
  void onInit() {
    super.onInit();
    _cartNotifier.getCartData();
    removeCouponData();
    _orderType.value = _configNotifier.config.value!.homeDelivery ? 'delivery' : 'take_away';
  }
}
