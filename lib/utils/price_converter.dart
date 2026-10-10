import 'package:efood/domain/models/config/config.dart';

class PriceConverter._() {
  static String convertPrice({double? discount, String? discountType, required double price, required Config? config}) {
    if (config == null) return "";

    if (discount != null && discountType != null) {
      if (discountType == 'amount') {
        price = price - discount;
      } else if (discountType == 'percent') {
        price = price - ((discount / 100) * price);
      }
    }

    return config.currencySymbolPosition == 'left'
        ? '${config.currencySymbol}'
              '${(price).toStringAsFixed(config.decimalPointSettings).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        : '${(price).toStringAsFixed(config.decimalPointSettings).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
              ' ${config.currencySymbol}';
  }

  static double convertWithDiscount({required double price, required double discount, required String discountType}) {
    if (discountType == 'amount') {
      price = price - discount;
    } else if (discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double convertDiscount({required double price, required double discount, required String discountType}) {
    if (discountType == 'amount') {
      price = discount;
    } else if (discountType == 'percent') {
      price = (discount / 100) * price;
    }
    return price;
  }

  static double calculation({
    required double amount,
    required double discount,
    required String type,
    required int quantity,
  }) {
    double calculatedAmount = 0;
    if (type == 'amount') {
      calculatedAmount = discount * quantity;
    } else if (type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation({
    required String price,
    required String discount,
    required String discountType,
    required String currencySymbol,
  }) {
    return '$discount${discountType == 'percent' ? '%' : currencySymbol} OFF';
  }
}
