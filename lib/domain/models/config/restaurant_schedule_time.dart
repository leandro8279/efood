import 'package:equatable/equatable.dart';

class const RestaurantScheduleTime({
  required final int day,
  required final String openingTime,
  required final String closingTime,
}) extends Equatable {
  @override
  List<Object?> get props => [day, openingTime, closingTime];
}
