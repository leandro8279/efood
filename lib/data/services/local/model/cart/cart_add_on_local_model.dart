import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_add_on_local_model.g.dart';

@JsonSerializable()
class const CartAddOnLocalModel({required final int id, required final int quantity}) extends Equatable {
  factory CartAddOnLocalModel.fromJson(Map<String, dynamic> json) => _$CartAddOnLocalModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartAddOnLocalModelToJson(this);

  @override
  List<Object?> get props => [id, quantity];
}
