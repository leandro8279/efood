import 'package:equatable/equatable.dart';

class const Policy._({
  required final Page? refundPage,
  required final Page? returnPage,
  required final Page? cancellationPage,
}) extends Equatable {
  @override
  List<Object?> get props => [cancellationPage, refundPage, returnPage];
}

class const Page._({required final String status}) extends Equatable {
  @override
  List<Object?> get props => [status];
}
