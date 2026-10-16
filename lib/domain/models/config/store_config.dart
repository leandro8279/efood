import 'package:equatable/equatable.dart';

class const StoreConfig({
  required final bool status,
  required final String link,
  required final String minVersion,
}) extends Equatable {
  @override
  List<Object?> get props => [status, link, minVersion];
}
