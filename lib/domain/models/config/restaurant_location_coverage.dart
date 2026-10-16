import 'package:equatable/equatable.dart';

class const RestaurantLocationCoverage({
  required final String longitude,
  required final String latitude,
  required final int coverage,
}) extends Equatable {
  @override
  List<Object?> get props => [longitude, latitude, coverage];
}
