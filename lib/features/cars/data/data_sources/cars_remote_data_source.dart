import 'package:car_store/core/constants/api_constants.dart';
import 'package:car_store/features/cars/data/models/car_details_response_model.dart';
import 'package:car_store/features/cars/data/models/cars_list_response_model.dart';
import 'package:car_store/features/cars/data/models/filter_options_model.dart';
import 'package:dio/dio.dart';

class CarsRemoteDataSource {
  final Dio _dio;

  const CarsRemoteDataSource(this._dio);

  Future<CarsListResponseModel> getFeaturedCars() async {
    final response = await _dio.get(ApiConstants.featuredCarsPath);
    return CarsListResponseModel.fromJson(response.data);
  }

  Future<CarsListResponseModel> getCars({
    int page = 1,
    int limit = 10,
    String? brand,
    String? condition,
    String? minPrice,
    String? maxPrice,
    String? city,
    String? sort,
  }) async {
    final response = await _dio.get(
      ApiConstants.carsPath,
      queryParameters: {
        'page': page,
        'limit': limit,
        if (brand != null && brand.isNotEmpty) 'brand': brand,
        if (condition != null && condition.isNotEmpty) 'condition': condition,
        if (minPrice != null && minPrice.isNotEmpty) 'minPrice': minPrice,
        if (maxPrice != null && maxPrice.isNotEmpty) 'maxPrice': maxPrice,
        if (city != null && city.isNotEmpty) 'city': city,
        if (sort != null && sort.isNotEmpty) 'sort': sort,
      },
    );
    return CarsListResponseModel.fromJson(response.data);
  }

  Future<CarDetailsResponseModel> getCarDetails(String carId) async {
    final response = await _dio.get('${ApiConstants.carsPath}/$carId');
    return CarDetailsResponseModel.fromJson(response.data);
  }

  Future<FilterOptionsModel> getFilterOptions() async {
    final response = await _dio.get(ApiConstants.filterOptionsPath);
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return FilterOptionsModel.fromJson(data);
    }
    return const FilterOptionsModel();
  }
}