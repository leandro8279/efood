import 'package:equatable/equatable.dart';

class const DeliveryManagement({
  required final int status,
  required final double minShippingCharge,
  required final double shippingPerKm,
}) extends Equatable {
  @override
  List<Object?> get props => [status, minShippingCharge, shippingPerKm];
}
