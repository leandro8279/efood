import 'package:efood/domain/models/config/base_url.dart';
import 'package:equatable/equatable.dart';

class const Config({
  required final String restaurantName,
  required final String restaurantLogo,
  required final String currencySymbol,
  required final bool maintenanceMode,
  required final bool emailVerification,
  required final bool phoneVerification,
  required final BaseUrl baseUrls,
  required final int decimalPointSettings,
  required final String currencySymbolPosition,
}) extends Equatable {
  @override
  List<Object?> get props => [
    restaurantLogo,
    restaurantName,
    currencySymbol,
    maintenanceMode,
    emailVerification,
    phoneVerification,
    baseUrls,
    currencySymbolPosition,
    decimalPointSettings,
  ];
}
