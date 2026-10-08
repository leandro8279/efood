import 'package:efood/data/services/api/model/config/config_api_model.dart';
import 'package:efood/domain/models/config/config.dart';

extension ConfigApiModelMapper on ConfigApiModel {
  Config toDomain() => Config(
    restaurantName: restaurantName,
    restaurantLogo: restaurantLogo,
    currencySymbol: currencySymbol,
    maintenanceMode: maintenanceMode,
    emailVerification: true,
    phoneVerification: false,
  );
}
