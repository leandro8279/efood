import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_local_model.g.dart';

@JsonSerializable()
class const ProductLocalModel() extends Equatable {
  factory ProductLocalModel.fromJson(Map<String, dynamic> json) => _$ProductLocalModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductLocalModelToJson(this);

  @override
  List<Object?> get props => [];
}
