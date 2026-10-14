import 'car_image_model.dart';
import 'car_seller_model.dart';

class CarModel {
  final String? id;
  final String? brand;
  final String? model;
  final int? year;
  final String? trim;
  final String? price;
  final String? originalPrice;
  final String? condition;
  final int? mileage;
  final String? modelType;
  final String? fuelType;
  final String? transmission;
  final String? driveType;
  final String? engineSize;
  final int? horsepower;
  final String? color;
  final int? doors;
  final int? seats;
  final List<String> features;
  final String? location;
  final String? city;
  final String? country;
  final String? rating;
  final int? reviewCount;
  final String? status;
  final bool? isFeatured;
  final int? viewCount;
  final String? description;
  final CarSellerModel? seller;
  final List<CarImageModel> images;

  const CarModel({
    this.id,
    this.brand,
    this.model,
    this.year,
    this.trim,
    this.price,
    this.originalPrice,
    this.condition,
    this.mileage,
    this.modelType,
    this.fuelType,
    this.transmission,
    this.driveType,
    this.engineSize,
    this.horsepower,
    this.color,
    this.doors,
    this.seats,
    this.features = const [],
    this.location,
    this.city,
    this.country,
    this.rating,
    this.reviewCount,
    this.status,
    this.isFeatured,
    this.viewCount,
    this.description,
    this.seller,
    this.images = const [],
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      year: json['year'] as int?,
      trim: json['trim'] as String?,
      price: json['price'] as String?,
      originalPrice: json['originalPrice'] as String?,
      condition: json['condition'] as String?,
      mileage: json['mileage'] as int?,
      modelType: json['modelType'] as String?,
      fuelType: json['fuelType'] as String?,
      transmission: json['transmission'] as String?,
      driveType: json['driveType'] as String?,
      engineSize: json['engineSize'] as String?,
      horsepower: json['horsepower'] as int?,
      color: json['color'] as String?,
      doors: json['doors'] as int?,
      seats: json['seats'] as int?,
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      location: json['location'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      rating: json['rating'] as String?,
      reviewCount: json['reviewCount'] as int?,
      status: json['status'] as String?,
      isFeatured: json['isFeatured'] as bool?,
      viewCount: json['viewCount'] as int?,
      description: json['description'] as String?,
      seller: json['seller'] == null
          ? null
          : CarSellerModel.fromJson(
              json['seller'] as Map<String, dynamic>,
            ),
      images: (json['images'] as List<dynamic>?)
              ?.map(
                (e) => CarImageModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  String? get primaryImageUrl {
    if (images.isEmpty) return null;

    return images.firstWhere(
      (img) => img.isPrimary == true,
      orElse: () => images.first,
    ).url;
  }

  String get displayName {
    return [brand, model]
        .where((value) => value != null && value.trim().isNotEmpty)
        .join(' ');
  }

  double? get ratingValue => double.tryParse(rating ?? '');
}