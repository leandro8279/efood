import 'package:equatable/equatable.dart';

class const Config({
  required final String restaurantName,
  required final String restaurantLogo,
  required final String currencySymbol,
  required final bool maintenanceMode,
  required final bool emailVerification,
  required final bool phoneVerification,
}) extends Equatable {
  @override
  List<Object?> get props => [
    restaurantLogo,
    restaurantName,
    currencySymbol,
    maintenanceMode,
    emailVerification,
    phoneVerification,
  ];
}
