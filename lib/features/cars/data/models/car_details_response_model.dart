import 'car_model.dart';

class CarDetailsResponseModel {
  final bool? success;
  final CarModel? data;

  const CarDetailsResponseModel({this.success, this.data});

  factory CarDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    CarModel? car;
    if (raw is Map<String, dynamic>) {
      // Some endpoints wrap in {"car": {...}}, others return the object directly.
      final inner = raw['car'];
      car = CarModel.fromJson(
        inner is Map<String, dynamic> ? inner : raw,
      );
    }
    return CarDetailsResponseModel(
      success: json['success'] as bool?,
      data: car,
    );
  }
}