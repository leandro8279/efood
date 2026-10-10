import 'package:efood/data/services/api/model/config/base_url_api_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'config_api_model.g.dart';

@JsonSerializable()
class const ConfigApiModel({
  required final String restaurantName,
  required final String restaurantLogo,
  required final String currencySymbol,
  required final bool maintenanceMode,
  required final bool emailVerification,
  required final bool phoneVerification,
  required final BaseUrlApiModel baseUrls,
  required final int decimalPointSettings,
  required final String currencySymbolPosition,
}) extends Equatable {
  factory ConfigApiModel.fromJson(Map<String, dynamic> json) {
    return _$ConfigApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConfigApiModelToJson(this);

  @override
  List<Object?> get props => [
    restaurantName,
    restaurantLogo,
    currencySymbol,
    maintenanceMode,
    emailVerification,
    phoneVerification,
    baseUrls,
    decimalPointSettings,
    currencySymbolPosition,
  ];
}
