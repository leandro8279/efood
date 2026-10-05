import 'package:equatable/equatable.dart';

class const OnBoarding({required final String title, required final String imageUrl, required final String description})
    extends Equatable {
  @override
  List<Object?> get props => [title, imageUrl, description];
}
