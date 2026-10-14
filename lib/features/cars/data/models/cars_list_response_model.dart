import 'car_model.dart';

class CarsListResponseModel {
  final bool? success;
  final CarsListData? data;

  const CarsListResponseModel({
    this.success,
    this.data,
  });

  factory CarsListResponseModel.fromJson(Map<String, dynamic> json) {
    return CarsListResponseModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : CarsListData.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
    );
  }
}

class CarsListData {
  final List<CarModel> cars;
  final PaginationModel? pagination;

  const CarsListData({
    this.cars = const [],
    this.pagination,
  });

  factory CarsListData.fromJson(Map<String, dynamic> json) {
    return CarsListData(
      cars: (json['cars'] as List<dynamic>?)
              ?.map(
                (e) => CarModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      pagination: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>,
            ),
    );
  }
}

class PaginationModel {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;
  final bool? hasNext;
  final bool? hasPrev;

  const PaginationModel({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
    this.hasNext,
    this.hasPrev,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      total: json['total'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      totalPages: json['totalPages'] as int?,
      hasNext: json['hasNext'] as bool?,
      hasPrev: json['hasPrev'] as bool?,
    );
  }
}