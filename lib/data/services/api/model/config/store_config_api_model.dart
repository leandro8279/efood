import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_config_api_model.g.dart';

@JsonSerializable()
class const StoreConfigApiModel({
  required final bool status,
  required final String link,
  required final String minVersion,
}) extends Equatable {
  factory StoreConfigApiModel.fromJson(Map<String, dynamic> json) => _$StoreConfigApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreConfigApiModelToJson(this);

  @override
  List<Object?> get props => [status, link, minVersion];
}
