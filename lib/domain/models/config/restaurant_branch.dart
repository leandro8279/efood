import 'package:equatable/equatable.dart';

class const RestaurantBranch({
  required final int id,
  required final String name,
  required final String email,
  required final String longitude,
  required final String latitude,
  required final String address,
  required final int coverage,
}) extends Equatable {
  @override
  List<Object?> get props => [id, name, email, longitude, latitude, address, coverage];
}
